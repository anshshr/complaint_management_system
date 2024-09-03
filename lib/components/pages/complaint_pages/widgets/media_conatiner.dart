import 'dart:io';

import 'package:flutter/material.dart';

class MediaConatiner extends StatelessWidget {
  final File mediaUrl;
  const MediaConatiner({super.key, required this.mediaUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 40,
        width: 70,
        decoration: BoxDecoration(
            image:
                DecorationImage(fit: BoxFit.cover, image: FileImage(mediaUrl)),
            color: Colors.grey[100],
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
