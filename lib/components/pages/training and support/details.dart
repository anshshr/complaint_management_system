import 'package:complaint_management_system/components/pages/training%20and%20support/training%20parts/dept_feedback.dart';
import 'package:complaint_management_system/components/pages/training%20and%20support/training%20parts/dept_problems.dart';
import 'package:complaint_management_system/components/pages/training%20and%20support/training%20parts/roles_responsibilities.dart';
import 'package:complaint_management_system/components/pages/training%20and%20support/training%20parts/videos.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  String Deptname;

  Details({
    super.key,
    required this.Deptname,
  });

  Widget Rolescard(String name, VoidCallback ontap) {
    return InkWell(
      onTap: ontap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        color: Colors.grey[100],
        shadowColor: Colors.grey[100],
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
          child: Text(
            textAlign: TextAlign.center,
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }

  List roles = [
    '📋Roles and Resposibilities',
    '🎥Guidance Videos',
    '💬 Department Feedaback',
    '⚠️Problems'
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      RolesResponsibilities(
        deptName: Deptname,
      ),
      Videos(
        deptname: Deptname,
      ),
      DeptFeedback(
        deptname: Deptname,
      ),
      DeptProblems(deptname: Deptname)
    ];

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 40),
        height: double.infinity,
        width: double.infinity,
        color: Colors.lightBlue[100],
        child: Column(
          children: [
            Text(
              Deptname,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            ListView.builder(
              itemCount: roles.length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return Rolescard(roles[index], () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => pages[index],
                      ));
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
