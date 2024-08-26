import 'package:complaint_management_system/components/app/splash_screen.dart';
import 'package:complaint_management_system/components/pages/home_page/home_page.dart';
import 'package:complaint_management_system/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  Gemini.init(apiKey: 'AIzaSyDi4t3C0UUeZArtyQiAO6alqKgwYc5JHio');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences pref = await SharedPreferences.getInstance();
  print(pref.getBool('login'));

  // This widget is the root of your application.
  runApp(MaterialApp(
    title: 'Rail Madad',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      useMaterial3: true,
    ),
    // if the user is logged then directed to home page else will show spalsh screen
    home: pref.getBool('login') == true
        ? HomePage(username: pref.getString('name')!)
        : SplashScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
