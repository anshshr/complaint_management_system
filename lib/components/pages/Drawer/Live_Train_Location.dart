import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'dart:convert';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:intl/intl.dart'; // For time formatting

class TrainTrackingScreen extends StatefulWidget {
  @override
  _TrainTrackingScreenState createState() => _TrainTrackingScreenState();
}

class _TrainTrackingScreenState extends State<TrainTrackingScreen> {
  TextEditingController _trainNumberController = TextEditingController();
  List<dynamic> _trainData = [];
  String _trainName = '';
  String _lastMessage = '';
  String _updatedTime = '';
  bool _isLoading = false;

  void _fetchTrainData(String trainNumber) async {
    setState(() {
      _isLoading = true;
    });

    final url = 'https://rappid.in/apis/train.php?train_no=$trainNumber';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _trainName = data['train_name'] ?? 'Unknown Train';
        _lastMessage = data['message'] ?? '';
        _updatedTime = data['updated_time'] ?? '';
        _trainData = data['data'] ?? [];
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      print('Failed to load train data');
    }
  }

  bool _isCurrentStation(String? stationTiming) {
    if (stationTiming == null || stationTiming.isEmpty) {
      return false;
    }

    try {
      final now = DateTime.now();
      final formatter = DateFormat('HH:mm');
      final stationTime = formatter.parse(stationTiming);

      return now.isAfter(stationTime.subtract(Duration(minutes: 10))) &&
          now.isBefore(stationTime.add(Duration(minutes: 10)));
    } catch (e) {
      print('Error parsing station time: $e');
      return false;
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
                controller: _trainNumberController,
                decoration: InputDecoration(
                  hintText: 'Enter train number',
                  hintStyle: TextStyle(color: Colors.grey[700]),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.0),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search, color: Colors.blue[900]),
                    onPressed: () {
                      _fetchTrainData(_trainNumberController.text);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            if (_isLoading)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Lottie.asset(
                          'assets/animation/train1.json',
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'On Track, Almost there ...',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              )
            else if (_trainName.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _trainName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.blue[900],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      _lastMessage,
                      style: TextStyle(color: Colors.blue[700]),
                    ),
                    SizedBox(height: 4),
                    Text(
                      _updatedTime,
                      style: TextStyle(color: Colors.blue[700]),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 20),
            Expanded(
              child: _trainData.isNotEmpty
                  ? ListView.builder(
                      itemCount: _trainData.length,
                      itemBuilder: (context, index) {
                        final station = _trainData[index];
                        final isCurrentStation =
                            _isCurrentStation(station['timing'] as String?);

                        return TimelineTile(
                          alignment: TimelineAlign.manual,
                          lineXY: 0.1,
                          isFirst: index == 0,
                          isLast: index == _trainData.length - 1,
                          indicatorStyle: IndicatorStyle(
                            width: 20,
                            color:
                                isCurrentStation ? Colors.green : Colors.white,
                            indicatorXY: 0.5,
                          ),
                          startChild: Container(
                            color: Colors.blue[800],
                          ),
                          endChild: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  station['station_name'] ?? 'Unknown Station',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Distance: ${station['distance'] ?? 'N/A'}',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                Text(
                                  'Timing: ${station['timing'] ?? 'N/A'}',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                Text(
                                  'Delay: ${station['delay'] ?? 'On Time'}',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                Text(
                                  'Platform: ${station['platform'] ?? 'N/A'}',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                Text(
                                  'Halt: ${station['halt'] ?? 'N/A'}',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                          beforeLineStyle: LineStyle(
                            color:
                                isCurrentStation ? Colors.green : Colors.white,
                            thickness: 4,
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(''),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
