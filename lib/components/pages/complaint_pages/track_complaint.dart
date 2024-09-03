import 'package:complaint_management_system/components/pages/complaint_pages/complaint_history_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TrackComplaint extends StatefulWidget {
  const TrackComplaint({super.key});

  @override
  _TrackComplaintState createState() => _TrackComplaintState();
}

class _TrackComplaintState extends State<TrackComplaint> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  bool _isValid = false;

  void _validateInput() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isValid = true;
      });
    } else {
      setState(() {
        _isValid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Enter 10-digit Reference Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                maxLength: 10,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a reference number';
                  } else if (value.length != 10) {
                    return 'Reference number must be 10 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _validateInput,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text('Track Complaint'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ComplaintHistoryPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text('Complaint History'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (_isValid)
                Expanded(
                  child: ListView.builder(
                    itemCount: 4, // Assuming 4 events in the complaint timeline
                    itemBuilder: (context, index) {
                      return _buildTimelineTile(index);
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineTile(int index) {
    List<Map<String, dynamic>> timelineData = [
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
        "title": "Complaint Resolved",
        "subtitle": "Your complaint has been resolved.",
        "icon": Icons.check_circle,
        "color": Colors.grey,
      },
    ];

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
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(timelineData[index]['subtitle']),
          ],
        ),
      ),
    );
  }
}
