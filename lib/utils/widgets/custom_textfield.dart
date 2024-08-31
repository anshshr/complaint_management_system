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
  final int? maxlines;

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
    this.maxlines,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0, // Adds a subtle shadow
      borderRadius: BorderRadius.circular(15.0),
      child: TextField(
        controller: controller,
        keyboardType: textInputType,
        onSubmitted: onsubmitted,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15,
              color: Colors.black54),
          labelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15,
              color: Colors.black87),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              color: Colors.transparent, // Removes border
              width: 0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              color: Colors.transparent, // Removes border
              width: 0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              color: Colors.blueAccent, // Blue border when focused
              width: 1.5,
            ),
          ),
          suffixIcon: suffixicon,
          prefixIcon: prefixicon,
          hintText: hinttext,
          labelText: labeltext,
        
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
        obscureText: obscurePassword,
        maxLines: 1,
      
      ),
    );
  }
}
