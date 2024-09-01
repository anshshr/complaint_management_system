import 'package:flutter/material.dart';

Widget customSliderContainer(
    int index, String title, Color color, String descText, String imagePath) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 5.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color.withOpacity(0.7),
          color.withOpacity(0.5),
          color.withOpacity(0.3),
          color.withOpacity(0.1),
        ],
      ),
      border: Border.all(width: 2, color: Colors.black87),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 19, color: Colors.black),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 110,
          width: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            descText,
            style: const TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
