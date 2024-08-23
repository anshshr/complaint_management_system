import 'package:complaint_management_system/components/pages/home_page.dart';
import 'package:complaint_management_system/components/pages/other_services.dart';
import 'package:complaint_management_system/services/auth/auth.dart';
import 'package:flutter/material.dart';
//TODO : use this custom drawer in every page for navigation and maintaining the design by @ansh

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});
  Authentication auth = Authentication();
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.grey[100],
        elevation: 10,
        child: ListView(
          children: [
            const SizedBox(
                height: 150,
                width: 70,
                child: CircleAvatar(
                  child: Icon(
                    Icons.person,
                    size: 90,
                    color: Colors.black87,
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 40, top: 10),
              leading: const Icon(
                Icons.home,
                color: Colors.black,
                size: 30,
              ),
              title: const Text(
                'H O M E ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              onTap: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) =>  HomePage(),
                ),
                (route) => false,
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 40, top: 10),
              leading: const Icon(
                Icons.person,
                color: Colors.black,
                size: 30,
              ),
              title: const Text(
                'P R O F I L E',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              onTap: () {},
            ),
            ListTile(
                contentPadding: const EdgeInsets.only(left: 40, top: 10),
                leading: const Icon(
                  Icons.settings,
                  color: Colors.black,
                  size: 30,
                ),
                title: const Text(
                  'S E T T I N G S',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                onTap: () {}),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 40, top: 10),
              leading: const Icon(
                Icons.room_service,
                color: Colors.black,
                size: 30,
              ),
              title: const Text(
                'O T H E R  S E R V I C E',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              onTap: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => OtherServicesPage(),
                ),
                (route) => false,
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 40, top: 10),
              leading: const Icon(
                Icons.logout,
                color: Colors.black,
                size: 30,
              ),
              title: const Text(
                'L O G O U T',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              onTap: () {
                auth.logout(context);
              },
            ),
          ],
        ));
  }
}
