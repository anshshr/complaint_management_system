// ignore_for_file: use_build_context_synchronously

import 'package:complaint_management_system/components/pages/home_page/home_page.dart';
import 'package:complaint_management_system/services/auth/auth.dart';
import 'package:complaint_management_system/utils/widgets/custom_button.dart';
import 'package:complaint_management_system/utils/widgets/custom_dialogbox.dart';
import 'package:complaint_management_system/utils/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool password = true;
  Authentication auth = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/railway1.jpg'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              height: 440,
              child: Card(
                color: Colors.white.withOpacity(0.6),
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "LET'S START YOUR JOURNEY",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextfield(
                          hinttext: 'Enter your user name',
                          obscurePassword: false,
                          labeltext: 'Enter your user name',
                          controller: username),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextfield(
                          hinttext: 'Enter your email',
                          obscurePassword: false,
                          labeltext: 'Enter your email',
                          controller: emailController),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextfield(
                          hinttext: 'Password',
                          obscurePassword: password,
                          labeltext: 'Password',
                          controller: passwordController,
                          suffixicon: IconButton(
                              onPressed: () {
                                setState(() {
                                  password = !password;
                                });
                              },
                              icon: password
                                  ? const Icon(
                                      Icons.visibility,
                                      color: Colors.black87,
                                    )
                                  : const Icon(
                                      Icons.visibility_off,
                                      color: Colors.black87,
                                    ))),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: InkWell(
                            onTap: () async {
                              TextEditingController email =
                                  TextEditingController();

                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              customDialogwithtextfield(context, email,
                                  () async {
                                await auth.forgotPassword(context, email.text);
                                if (pref.getString('error') != null ||
                                    pref.getString('error') != '') {
                                  customDialog(
                                      context, pref.getString('error')!);
                                } else {
                                  Navigator.pop(context);
                                }
                              });
                            },
                            child: const Text(
                              'Forget Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                        text: 'Sign In',
                        ontap: () async {
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          if (passwordController.text.isNotEmpty &&
                              emailController.text.isNotEmpty &&
                              username.text.isNotEmpty) {
                            await auth.loginUser(context, emailController.text,
                                passwordController.text);

                            if (pref.getString('error') == null ||
                                pref.getString('error') == '') {
                              pref.setString('name', username.text);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HomePage(username: username.text),
                                ),
                              );
                            } else {
                              customDialog(context, pref.getString('error')!);
                            }
                          } else {
                            customDialog(
                                context, "Please Fill all the Details");
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
