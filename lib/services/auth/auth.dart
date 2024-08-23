// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:complaint_management_system/utils/widgets/custom_dialogbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  final FirebaseAuth auth = FirebaseAuth.instance;

  //register the user
  Future registerUser(
      BuildContext context, String email, String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
            pref.setString('error', '');
    } on FirebaseAuthException catch (e) {
      pref.setString('error', e.code);
      print(e.code);
      return;
    }
  }

  //login the user
  Future loginUser(BuildContext context, String email, String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
            pref.setString('error', '');

    } on FirebaseAuthException catch (e) {
      pref.setString('error', e.code);
      print(e.code);
      return;
    }
  }

  //logout the user
  Future logout(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      await auth.signOut();
            pref.setString('error', '');

    } on FirebaseAuthException catch (e) {
      pref.setString('error', e.code);
      print(e.code);
      return;
    }
  }

  //forgot password

  Future forgotPassword(BuildContext context, String email) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      await auth.sendPasswordResetEmail(email: email);
            pref.setString('error', '');
      
    } on FirebaseAuthException catch (e) {
      pref.setString('error', e.code);
      print(e.code);
      return;
    }
  }
}
