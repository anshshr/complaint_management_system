import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'dart:convert';
import 'package:timeline_tile/timeline_tile.dart';

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
              SingleChildScrollView(
                child: Center(
                  child: Container(
                    color: Colors.white.withOpacity(0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset('assets/animation/train1.json'),
                        Text(
                          'On Track, Almost there ...',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w800),
                        )
                      ],
                    ),
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
                        return TimelineTile(
                          alignment: TimelineAlign.manual,
                          lineXY: 0.1,
                          isFirst: index == 0,
                          isLast: index == _trainData.length - 1,
                          indicatorStyle: IndicatorStyle(
                            width: 20,
                            color: station['is_current_station']
                                ? Colors.green
                                : Colors.white,
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
                            color: Colors.white,
                            thickness: 4,
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        '',
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
