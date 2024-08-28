import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class LocationNotifier extends StateNotifier<Position?> {
  LocationNotifier() : super(null);

  Future<void> fetchCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      state = null;
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        state = null;
        return;
      }
    }

    state = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}

final locationProvider = StateNotifierProvider<LocationNotifier, Position?>(
  (ref) => LocationNotifier(),
);
