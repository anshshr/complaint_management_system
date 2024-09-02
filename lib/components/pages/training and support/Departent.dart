import 'package:complaint_management_system/components/pages/training%20and%20support/details.dart';
import 'package:complaint_management_system/utils/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class Department extends StatelessWidget {
  Department({super.key});

  Widget departmentCard(String name, String imagePath, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        shadowColor: Colors.grey[300],
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  height: 80,
                  width: 80,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Railway Departments',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.blue[400],
      ),
      drawer: CustomDrawer(
        username: '',
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        color: Colors.blue[50],
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.0,
            crossAxisCount: 2,
          ),
          padding: const EdgeInsets.all(10),
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
      ),
    );
  }
}
