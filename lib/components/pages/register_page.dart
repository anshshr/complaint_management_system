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
  TextEditingController passController = TextEditingController();
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
          image: DecorationImage(
            image: AssetImage('assets/images/railway2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              height: 500,
              child: Card(
                color: Colors.white.withOpacity(0.7),
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'WELCOME BUDDY',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomTextfield(
                        hinttext: 'Enter your name',
                        obscurePassword: false,
                        labeltext: 'Enter your name',
                        controller: nameController,
                      ),
                      const SizedBox(height: 20),
                      CustomTextfield(
                        hinttext: 'Enter your email',
                        obscurePassword: false,
                        labeltext: 'Enter your email',
                        controller: emailController,
                      ),
                      const SizedBox(height: 20),
                      CustomTextfield(
                        hinttext: 'Password',
                        obscurePassword: password,
                        labeltext: 'Password',
                        controller: passController,
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
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextfield(
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
                          icon: confirmPass
                              ? const Icon(
                                  Icons.visibility,
                                  color: Colors.black87,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  color: Colors.black87,
                                ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomButton(
                        text: 'Sign Up',
                        ontap: () async {
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          if (passController.text.isNotEmpty &&
                              emailController.text.isNotEmpty &&
                              nameController.text.isNotEmpty &&
                              confirmPassword.text.isNotEmpty) {
                            if (passController.text == confirmPassword.text) {
                              await auth.registerUser(
                                context,
                                emailController.text,
                                passController.text,
                              );
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
                            customDialog(
                                context, "Please Fill all the Details");
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already a member, ',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black87,
                              fontSize: 15,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            child: const Text(
                              'login here',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.redAccent,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
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
