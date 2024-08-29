import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ComplaintHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'Complaint History',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            unselectedLabelStyle: TextStyle(fontSize: 16),
            dividerColor: Colors.black,
            tabs: [
              Tab(text: 'Complaint Solved'),
              Tab(text: 'Complaint Pending'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SolvedComplaintsTab(),
            PendingComplaintsTab(),
          ],
        ),
      ),
    );
  }
}

class SolvedComplaintsTab extends StatelessWidget {
  final List<Map<String, String>> solvedComplaints = [
    {
      "title": "Train Delay",
      "description": "Complaint about train delay resolved on 10/08/2024.",
      "date": "10/08/2024",
    },
    {
      "title": "Unclean Station",
      "description": "Complaint about unclean station resolved on 15/08/2024.",
      "date": "15/08/2024",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: solvedComplaints.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
          child: Card(
            elevation: 2,
            color: Colors.grey[200],
            child: ListTile(
              title: Text(
                solvedComplaints[index]['title']!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(solvedComplaints[index]['description']!),
              trailing: Text(solvedComplaints[index]['date']!),
            ),
          ),
        );
      },
    );
  }
}

class PendingComplaintsTab extends StatelessWidget {
  final List<Map<String, dynamic>> timelineData = [
    {
      "title": "Complaint Registered",
      "subtitle": "Your complaint has been registered.",
      "icon": Icons.how_to_reg,
      "color": Colors.green,
    },
    {
      "title": "Complaint Reviewed",
      "subtitle": "Your complaint is under review.",
      "icon": Icons.assignment,
      "color": Colors.orange,
    },
    {
      "title": "Action Taken",
      "subtitle": "Necessary actions have been taken.",
      "icon": Icons.build,
      "color": Colors.blue,
    },
    {
      "title": "Pending Resolution",
      "subtitle": "Awaiting resolution.",
      "icon": Icons.pending,
      "color": Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: timelineData.length,
          itemBuilder: (context, index) {
            return TimelineTile(
              alignment: TimelineAlign.start,
              isFirst: index == 0,
              isLast: index == timelineData.length - 1,
              indicatorStyle: IndicatorStyle(
                width: 40,
                color: timelineData[index]['color'],
                iconStyle: IconStyle(
                  color: Colors.white,
                  iconData: timelineData[index]['icon'],
                ),
              ),
              beforeLineStyle: LineStyle(
                color: timelineData[index]['color'],
                thickness: 6,
              ),
              afterLineStyle: LineStyle(
                color: index < timelineData.length - 1
                    ? timelineData[index + 1]['color']
                    : Colors.grey,
                thickness: 6,
              ),
              endChild: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      timelineData[index]['title'],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6),
                    Text(timelineData[index]['subtitle']),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
