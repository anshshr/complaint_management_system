import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String hinttext;
  bool obscurePassword;
  final String labeltext;
  final IconButton? suffixicon;
  final Icon? prefixicon;
  final TextInputType? textInputType;
  final TextEditingController controller;
  ValueChanged<String>? onsubmitted;

  CustomTextfield({
    super.key,
    required this.hinttext,
    required this.obscurePassword,
    required this.labeltext,
    this.suffixicon,
    this.prefixicon,
    this.textInputType,
    required this.controller,
    this.onsubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      onSubmitted: onsubmitted,
      decoration: InputDecoration(
          hintStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15,
              color: Colors.black87),
          labelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15,
              color: Colors.black87),
          border: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              color: Colors.black87,
              width: 1,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              color: Colors.black87,
              width: 1,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
                color: Colors.black87, width: 1, style: BorderStyle.solid),
          ),
          suffixIcon: suffixicon,
          prefixIcon: prefixicon,
          hintText: hinttext,
          labelText: labeltext,
          contentPadding:
              const EdgeInsets.only(top: 10, left: 10, right: 3, bottom: 5)),
      obscureText: obscurePassword,
    );
  }
}
