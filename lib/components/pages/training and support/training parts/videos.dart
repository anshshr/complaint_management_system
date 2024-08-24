// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Videos extends StatefulWidget {
  String deptname;
  Videos({
    super.key,
    required this.deptname,
  });

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.only(top: 40),
          height: double.infinity,
          width: double.infinity,
          color: Colors.red[100],
          child: Column(
            children: [
              Text(
                textAlign: TextAlign.center,
                '${widget.deptname} Videos',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          )),
    );
  }
}
