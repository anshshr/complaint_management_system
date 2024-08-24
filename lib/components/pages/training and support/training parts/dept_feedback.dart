import 'package:flutter/material.dart';

class DeptFeedback extends StatefulWidget {
  String deptname;
  DeptFeedback({
    super.key,
    required this.deptname,
  });

  @override
  State<DeptFeedback> createState() => _DeptFeedbackState();
}

class _DeptFeedbackState extends State<DeptFeedback> {
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
                '${widget.deptname} Feedbacks',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          )),
    );
  }
}
