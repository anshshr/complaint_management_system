import 'package:complaint_management_system/components/pages/training%20and%20support/details.dart';
import 'package:flutter/material.dart';

class Department extends StatelessWidget {
  Department({super.key});

  Widget departmentCard(String name, String imagePath, VoidCallback ontap) {
    return InkWell(
      onTap: ontap,
      child: Card(
        color: Colors.grey[100],
        shadowColor: Colors.grey[100],
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 70,
            ),
            const SizedBox(height: 6),
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<String> deptImages = [
    'assets/images/engineering.jpeg',
    'assets/images/electrical.webp',
    'assets/images/traffic.webp',
    'assets/images/medical.png',
    'assets/images/security.webp',
    'assets/images/housekeeping.png',
    'assets/images/food.webp',
  ];

  final List<String> departments = [
    'Engineering Department',
    'Electrical Department',
    'Traffic Department',
    'Medical Department',
    'Security Department',
    'Housekeeping Department',
    'Food Department',
  ];

  final List<Widget> departmentPages = [];

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
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  'Railway Departments',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.0,
                crossAxisCount: 2,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: departments.length,
              itemBuilder: (context, index) {
                return departmentCard(
                  departments[index],
                  deptImages[index],
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Details(
                          Deptname: departments[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
