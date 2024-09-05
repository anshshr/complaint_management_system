import 'package:complaint_management_system/components/pages/training%20and%20support/training%20parts/department_problem_chart.dart';
import 'package:flutter/material.dart';
import 'package:complaint_management_system/services/api/station_complaints_api.dart';
import 'package:complaint_management_system/services/api/train_complaints_api.dart';
import 'package:fl_chart/fl_chart.dart'; // Import the fl_chart package for PieChart

class DeptProblems extends StatefulWidget {
  final String deptname;

  DeptProblems({super.key, required this.deptname});

  @override
  State<DeptProblems> createState() => _DeptProblemsState();
}

class _DeptProblemsState extends State<DeptProblems> {
  List<Map<String, dynamic>> trainData = [];
  List<Map<String, dynamic>> stationData = [];
  bool showComplaints = true;

  @override
  void initState() {
    super.initState();
    getTrainProblems();
    getStationProblems();
  }

  Future<void> getTrainProblems() async {
    List<Map<String, dynamic>> apiData =
        await get_train_complaints(widget.deptname);

    setState(() {
      trainData = apiData;
    });
  }

  Future<void> getStationProblems() async {
    List<Map<String, dynamic>> apiData =
        await fetch_station_complaints(widget.deptname);

    setState(() {
      stationData = apiData;
    });
  }

  // Function to toggle between complaints and common problems
  void toggleView() {
    setState(() {
      showComplaints = !showComplaints;
    });
  }

  // Widget to build individual complaint cards
  Widget buildComplaintCard(Map<String, dynamic> complaint, bool isTrain) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isTrain
                  ? complaint['Trainname'] ?? 'Unknown Train'
                  : complaint['Stationname'] ?? 'Unknown Station',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Date: ${complaint['date'] ?? 'Unknown Date'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'PNR: ${complaint['pnrno']?.toString() ?? 'N/A'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Berth No : ${complaint['berth_no']?.toString() ?? 'N/A'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Coach No : ${complaint['coach_no']?.toString() ?? 'N/A'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Platform No : ${complaint['platform_no']?.toString() ?? 'N/A'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              complaint['problem_desc'] ?? 'No description available',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            // if (complaint['imageUrl'] != null &&
            //     complaint['imageUrl'].isNotEmpty)
            //   Image.file(
            //     complaint['imageUrl'][0],
            //     height: 200,
            //     width: double.infinity,
            //     fit: BoxFit.cover,
            //   ),
          ],
        ),
      ),
    );
  }

  // Function to calculate the percentage for the pie chart
  Map<String, double> calculateProblemDistribution() {
    Map<String, int> problemCounts = {
      'Train Delay': 0,
      'Cleanliness': 0,
      'Staff Behavior': 0,
      'Other': 0,
    };

    for (var complaint in trainData + stationData) {
      String problemDesc = (complaint['problem_desc'] as String).toLowerCase();

      if (problemDesc.contains('delay')) {
        problemCounts['Train Delay'] = problemCounts['Train Delay']! + 1;
      } else if (problemDesc.contains('clean')) {
        problemCounts['Cleanliness'] = problemCounts['Cleanliness']! + 1;
      } else if (problemDesc.contains('staff') ||
          problemDesc.contains('behavior')) {
        problemCounts['Staff Behavior'] = problemCounts['Staff Behavior']! + 1;
      } else {
        problemCounts['Other'] = problemCounts['Other']! + 1;
      }
    }

    int totalComplaints =
        problemCounts.values.fold(0, (sum, count) => sum + count);

    return problemCounts
        .map((key, value) => MapEntry(key, (value / totalComplaints) * 100));
  }

  // Widget to build the pie chart with dynamic data
  Widget buildPieChart() {
    Map<String, double> problemDistribution = calculateProblemDistribution();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Most Common Problems',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: problemDistribution['Train Delay']!,
                      color: Colors.blue,
                      radius: 60,
                      title:
                          '${problemDistribution['Train Delay']!.toStringAsFixed(1)}%',
                      titleStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      value: problemDistribution['Cleanliness']!,
                      color: Colors.green,
                      radius: 60,
                      title:
                          '${problemDistribution['Cleanliness']!.toStringAsFixed(1)}%',
                      titleStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      value: problemDistribution['Staff Behavior']!,
                      color: Colors.orange,
                      radius: 60,
                      title:
                          '${problemDistribution['Staff Behavior']!.toStringAsFixed(1)}%',
                      titleStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      value: problemDistribution['Other']!,
                      color: Colors.red,
                      radius: 60,
                      title:
                          '${problemDistribution['Other']!.toStringAsFixed(1)}%',
                      titleStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                  sectionsSpace: 2,
                  centerSpaceRadius: 50,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LegendItem(color: Colors.blue, text: 'Train Delay'),
                LegendItem(color: Colors.green, text: 'Cleanliness'),
                LegendItem(color: Colors.orange, text: 'Staff Behavior'),
                LegendItem(color: Colors.red, text: 'Other'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget to display the list of complaints
  Widget complaintsList() {
    return Container(
      color: Colors.blue[50],
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          // Train Complaints Section
          ListTile(
            title: const Text(
              'Train Complaints',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          if (trainData.isNotEmpty)
            ...trainData
                .map((complaint) => buildComplaintCard(complaint, true))
                .toList()
          else
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: Text('No train data available')),
            ),

          const SizedBox(height: 20),

          // Station Complaints Section
          ListTile(
            title: const Text(
              'Station Complaints',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          if (stationData.isNotEmpty)
            ...stationData
                .map((complaint) => buildComplaintCard(complaint, false))
                .toList()
          else
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: Text('No station data available')),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.deptname} Problems',
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        backgroundColor: Colors.blue[400],
        actions: [
          IconButton(
            icon: Icon(showComplaints ? Icons.pie_chart : Icons.list),
            onPressed: toggleView,
            tooltip:
                showComplaints ? 'Show Common Problems' : 'Show Complaints',
          ),
        ],
      ),
      body: showComplaints
          ? (trainData.isNotEmpty || stationData.isNotEmpty
              ? complaintsList()
              : const Center(
                  child: Text(
                    'No complaints available',
                    style: TextStyle(fontSize: 18),
                  ),
                ))
          : buildPieChart(), // Display the pie chart when the toggle is activated
    );
  }
}
