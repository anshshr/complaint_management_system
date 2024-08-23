// ignore_for_file: use_build_context_synchronously

import 'package:complaint_management_system/components/pages/login_page.dart';
import 'package:complaint_management_system/services/auth/auth.dart';
import 'package:complaint_management_system/utils/widgets/custom_button.dart';
import 'package:complaint_management_system/utils/widgets/custom_dialogbox.dart';
import 'package:complaint_management_system/utils/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passControlller = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();
  bool password = true;
  bool confirmPass = true;

  Authentication auth = Authentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.blue[100]!,
              Colors.blue[200]!,
              Colors.blue[100]!,
              Colors.blue[300]!,
              Colors.blue[100]!,
            ])),
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              height: 800,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'WELCOME BUDDY',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: CustomTextfield(
                        hinttext: 'Enter your name',
                        obscurePassword: false,
                        labeltext: 'Enter your name',
                        controller: nameController),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: CustomTextfield(
                        hinttext: 'Enter your email',
                        obscurePassword: false,
                        labeltext: 'Enter your email',
                        controller: emailController),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: CustomTextfield(
                        hinttext: 'Password',
                        obscurePassword: password,
                        labeltext: 'Password',
                        controller: passControlller,
                        suffixicon: IconButton(
                            onPressed: () {
                              setState(() {
                                password = !password;
                              });
                            },
                            icon: password == true
                                ? const Icon(
                                    Icons.visibility,
                                    color: Colors.black87,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: Colors.black87,
                                  ))),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: CustomTextfield(
                        hinttext: 'Confirm password',
                        obscurePassword: confirmPass,
                        labeltext: 'Confirm password',
                        controller: confirmPassword,
                        suffixicon: IconButton(
                            onPressed: () {
                              setState(() {
                                confirmPass = !confirmPass;
                              });
                            },
                            icon: confirmPass == true
                                ? const Icon(
                                    Icons.visibility,
                                    color: Colors.black87,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: Colors.black87,
                                  ))),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    text: 'Sign Up',
                    ontap: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      if (passControlller.text != "" &&
                          passControlller.text.isNotEmpty &&
                          emailController.text != "" &&
                          emailController.text.isNotEmpty &&
                          nameController.text != "" &&
                          nameController.text.isNotEmpty &&
                          confirmPassword.text != "" &&
                          confirmPassword.text.isNotEmpty) {
                        if (passControlller.text == confirmPassword.text) {
                          await auth.registerUser(context, emailController.text,
                              passControlller.text);
                          if (pref.getString('error') == null ||
                              pref.getString('error') == '') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          } else {
                            customDialog(context, pref.getString('error')!);
                          }
                        } else {
                          customDialog(context, "Passwords don't match");
                          return;
                        }
                      } else {
                        //dialog to show plese fill all the details
                        customDialog(context, "Please Fill all the Details");
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already a member, ',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black87,
                            fontSize: 15),
                      ),
                      InkWell(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ));
                          },
                          child: const Text(
                            ' login here',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.redAccent,
                                fontSize: 15),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
