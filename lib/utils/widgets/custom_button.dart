import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  VoidCallback? ontap;

  CustomButton({
    super.key,
    required this.text,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 60,
        width: 290,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blueAccent
              .withOpacity(0.9), // Subtle blue background with opacity
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26, // Subtle shadow effect
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
          gradient: LinearGradient(
            colors: [
              Colors.blueAccent.withOpacity(0.9),
              Colors.lightBlueAccent.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.white, // White text color for contrast
            ),
          ),
        ),
      ),
    );
  }
}
