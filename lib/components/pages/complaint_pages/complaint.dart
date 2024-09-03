import 'package:complaint_management_system/components/pages/complaint_pages/station_complaint.dart';
import 'package:complaint_management_system/components/pages/complaint_pages/track_complaint.dart';
import 'package:complaint_management_system/components/pages/complaint_pages/train_complaint.dart';
import 'package:flutter/material.dart';

class Complaint extends StatelessWidget {
  const Complaint({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: TabBar(
                    indicatorColor: Colors.blue,
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.grey[600],
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    tabs: const [
                      Tab(text: '    Train \nComplaint'),
                      Tab(text: '  Station\nComplaint'),
                      Tab(text: '    Track \nComplaint'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      TrainComplaint(),
                      const StationComplaint(),
                      const TrackComplaint(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
