import 'dart:io';

import 'package:flutter/material.dart';

class MediaConatiner extends StatelessWidget {
  final File mediaUrl;
  const MediaConatiner({super.key, required this.mediaUrl});

  @override
  Widget build(BuildContext context) {
    String fileType = mediaUrl.path.split('.').last.toLowerCase();
    Widget mediaWidget;

    if (fileType == 'jpg' || fileType == 'jpeg' || fileType == 'png') {
      mediaWidget = Image.file(mediaUrl, fit: BoxFit.cover);
    } else if (fileType == 'mp3' || fileType == 'wav') {
      mediaWidget = Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqDQSHxRjP_c9YnQ-wEI2v8Lhk-i-uvyrU2w&s', fit: BoxFit.cover);
    } else if (fileType == 'mp4' || fileType == 'mov') {
      mediaWidget = Image.network('https://pbs.twimg.com/media/E1ISt3qWYAcTSiX?format=jpg&name=4096x4096', fit: BoxFit.cover);
    } else {
      mediaWidget = Container(); // Display an empty container for unsupported file types
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 40,
        width: 70,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: mediaWidget,
      ),
    );
  }
}
