import 'package:complaint_management_system/components/pages/training%20and%20support/details.dart';
import 'package:flutter/material.dart';

class Department extends StatelessWidget {
  Department({super.key});

  Widget departmentCard(String name, VoidCallback ontap) {
    return InkWell(
      onTap: ontap,
      child: Card(
        color: Colors.grey[100],
        shadowColor: Colors.grey[100],
        elevation: 2,
        child: Text(
          textAlign: TextAlign.center,
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }

  List departmets = [
    '👷‍♂️Engineering Department',
    '⚡Electrical Department',
    '🚦Traffic Department',
    '🏥Medical Department',
    '🪪Security Department',
    '🏠Housekeeping Department',
    '🍇Food Department'
  ];

  List departmentpages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      body: Container(
        padding: const EdgeInsets.only(top: 40),
        height: double.infinity,
        width: double.infinity,
        color: Colors.red[100],
        child: Column(
          children: [
            const Text(
              ' Railway Departments',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.8,
                  crossAxisCount: 2),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: departmets.length,
              itemBuilder: (context, index) {
                return departmentCard(departmets[index], () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Details(
                          Deptname: departmets[index],
                        ),
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
