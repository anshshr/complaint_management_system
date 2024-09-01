import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StationScreen extends StatefulWidget {
  const StationScreen({super.key});

  @override
  _StationScreenState createState() => _StationScreenState();
}

class _StationScreenState extends State<StationScreen> {
  final TextEditingController _stationController = TextEditingController();
  List<dynamic> _stationData = [];
  bool _isLoading = false;

  void _fetchStationData(String input) async {
    setState(() {
      _isLoading = true;
    });

    final url =
        'https://indianrailapi.com/api/v2/AutoCompleteStation/apikey/0ec3f225d4c2f59e8ab50c5df958426a/StationCodeOrName/$input/';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _stationData = data['Station'] ?? [];
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      print('Failed to load station data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _stationController,
                decoration: InputDecoration(
                  hintText: 'Enter station code or name',
                  hintStyle: TextStyle(color: Colors.grey[700]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16.0),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search, color: Colors.blue[900]),
                    onPressed: () {
                      _fetchStationData(_stationController.text);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : _stationData.isNotEmpty
                      ? ListView.builder(
                          itemCount: _stationData.length,
                          itemBuilder: (context, index) {
                            final station = _stationData[index];
                            return Card(
                              color: Colors.white,
                              child: ListTile(
                                title: Text(
                                  station['NameEn'] ?? 'Unknown Station',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.blue[900],
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      station['NameHn'] ?? '',
                                      style: TextStyle(
                                        color: Colors.blue[700],
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      'Station Code: ${station['StationCode'] ?? 'N/A'}',
                                      style: TextStyle(color: Colors.blue[700]),
                                    ),
                                    Text(
                                      'Coordinates: ${station['Latitude']}, ${station['Longitude']}',
                                      style: TextStyle(color: Colors.blue[700]),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text(
                            'No station data found',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
