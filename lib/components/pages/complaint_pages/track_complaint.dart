import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';

class TrackComplaint extends StatelessWidget {
  const TrackComplaint({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return complaint_card('complaint1', '23-34-56');
      },
    ));
  }
}

Widget complaint_card(
  String complaint_headline,
  String date,
) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    elevation: 2,
    color: Colors.grey[100],
    shadowColor: Colors.grey[100],
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            complaint_headline,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            date,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
          )
        ],
      ),
    ),
  );
}
