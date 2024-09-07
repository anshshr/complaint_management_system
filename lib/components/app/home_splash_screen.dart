import 'dart:async';

import 'package:complaint_management_system/components/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeSplashScreen extends StatefulWidget {
  final String username;
  const HomeSplashScreen({super.key, required this.username});

  @override
  State<HomeSplashScreen> createState() => _HomeSplashScreenState();
}

class _HomeSplashScreenState extends State<HomeSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => HomePage(
                username: widget.username,
                changeLanguage: (String languageCode) {})),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.network(
              'https://lottie.host/7ce98aa1-3844-4d4b-bb43-b3b70e4d3e03/0oLOTe3LXC.json',
              height: 300,
              width: 300),
          SizedBox(
            height: 20,
          ),
          Text(
            "Let's start your journey...",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.5,
                color: Colors.black87),
          )
        ],
      )),
    );
  }
}
