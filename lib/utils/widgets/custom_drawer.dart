import 'package:complaint_management_system/components/pages/home_page.dart';
import 'package:complaint_management_system/components/pages/other_services.dart';
import 'package:complaint_management_system/services/auth/auth.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final String username;

  CustomDrawer({super.key, required this.username});

  Authentication auth = Authentication();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      elevation: 1,
      child: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 70,
            width: 70,
            child: CircleAvatar(
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Hello, $username',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 40, top: 10),
            leading: const Icon(
              Icons.home,
              color: Colors.black,
              size: 26,
            ),
            title: const Text(
              'H O M E ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            onTap: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(username: username),
              ),
              (route) => false,
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 40, top: 10),
            leading: const Icon(
              Icons.person,
              color: Colors.black,
              size: 26,
            ),
            title: const Text(
              'P R O F I L E',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            onTap: () {
              // Add navigation to Profile page and pass username if needed
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 40, top: 10),
            leading: const Icon(
              Icons.settings,
              color: Colors.black,
              size: 26,
            ),
            title: const Text(
              'S E T T I N G S',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            onTap: () {
              // Add navigation to Settings page
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 40, top: 10),
            leading: const Icon(
              Icons.room_service,
              color: Colors.black,
              size: 26,
            ),
            title: const Text(
              'O T H E R  S E R V I C E',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            onTap: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => OtherServicesPage(username: username),
              ),
              (route) => false,
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 40, top: 10),
            leading: const Icon(
              Icons.logout,
              color: Colors.black,
              size: 26,
            ),
            title: const Text(
              'L O G O U T',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            onTap: () {
              auth.logout(context);
            },
          ),
        ],
      ),
    );
  }
}