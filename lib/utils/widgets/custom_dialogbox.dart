import 'package:complaint_management_system/utils/widgets/custom_button.dart';
import 'package:complaint_management_system/utils/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

Future customDialog(BuildContext context, String message) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        elevation: 6,
        backgroundColor: Colors.grey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Alert',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          Column(
            children: [
              Text(
                message,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomButton(
                  text: 'Okay',
                  ontap: () {
                    Navigator.pop(context);
                  })
            ],
          ),
        ],
      );
    },
  );
}

Future customDialogwithtextfield(BuildContext context,
    TextEditingController controller, VoidCallback? ontap) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        elevation: 6,
        backgroundColor: Colors.grey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Forgot Password',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          SizedBox(
            width: 800,
            child: Column(
              children: [
                CustomTextfield(
                    hinttext: 'Enter your email',
                    obscurePassword: false,
                    labeltext: 'Enter your email',
                    controller: controller),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(text: 'SEND EMAIL', ontap: () {})
              ],
            ),
          ),
        ],
      );
    },
  );
}
