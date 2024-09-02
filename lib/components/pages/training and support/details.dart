import 'package:complaint_management_system/components/pages/training%20and%20support/training%20parts/dept_feedback.dart';
import 'package:complaint_management_system/components/pages/training%20and%20support/training%20parts/dept_problems.dart';
import 'package:complaint_management_system/components/pages/training%20and%20support/training%20parts/roles_responsibilities.dart';
import 'package:complaint_management_system/components/pages/training%20and%20support/training%20parts/videos.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final String Deptname;

  Details({
    super.key,
    required this.Deptname,
  });

  Widget Rolescard(String name, IconData icon, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      color: Colors.white,
      shadowColor: Colors.grey[400],
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Colors.blue[400]),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blue[800],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List roles = [
    {'title': 'Roles and Responsibilities', 'icon': Icons.assignment},
    {'title': 'Guidance Videos', 'icon': Icons.video_collection},
    {'title': 'Department Feedback', 'icon': Icons.feedback},
    {'title': 'Problems', 'icon': Icons.warning},
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      RolesResponsibilities(deptName: Deptname),
      Videos(deptname: Deptname),
      DeptFeedback(deptname: Deptname),
      DeptProblems(deptname: Deptname),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          Deptname,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.blue[300],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        color: Colors.blue[50],
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: roles.length,
                itemBuilder: (context, index) {
                  return Rolescard(
                    roles[index]['title']!,
                    roles[index]['icon'] as IconData,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => pages[index],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
