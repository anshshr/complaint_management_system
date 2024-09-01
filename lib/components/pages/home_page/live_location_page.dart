import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:lottie/lottie.dart';

class LiveLocationPage extends StatefulWidget {
  const LiveLocationPage({super.key});

  @override
  _LiveLocationPageState createState() => _LiveLocationPageState();
}

class _LiveLocationPageState extends State<LiveLocationPage> {
  String _locationMessage = "";
  bool _isLoading = false;

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Check for permissions
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _locationMessage = "Location services are disabled.";
          _isLoading = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          setState(() {
            _locationMessage = "Location permissions are denied";
            _isLoading = false;
          });
          return;
        }
      }

      // Attempt to get the last known location first
      Position? position = await Geolocator.getLastKnownPosition();
      if (position == null) {
        // If no last known location, request a new position
        position = await Geolocator.getCurrentPosition(
          desiredAccuracy:
              LocationAccuracy.low, // Lower accuracy for faster response
        );
      }

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      setState(() {
        _locationMessage =
            "Latitude: ${position?.latitude}\nLongitude: ${position?.longitude}\n\n"
            "Address: ${placemarks.first.street ?? ''}, ${placemarks.first.locality ?? ''}, ${placemarks.first.country ?? ''}";
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _locationMessage = "Error: ${e.toString()}";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Live Location',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _getCurrentLocation,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue, // Text color
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  elevation: 5,
                ),
                child: const Text('Get Current Location'),
              ),
              SizedBox(height: 20),
              _isLoading
                  ? Lottie.asset(
                      'assets/animation/dept1.json',
                      width: 150,
                      height: 150,
                    )
                  : Card(
                      elevation: 2,
                      color: Colors.blue[100],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _locationMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
