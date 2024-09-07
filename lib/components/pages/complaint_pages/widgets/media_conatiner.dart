import 'dart:io';

import 'package:flutter/material.dart';

class MediaConatiner extends StatelessWidget {
  final File mediaUrl;
  VoidCallback ontap;
  MediaConatiner({super.key, required this.mediaUrl, required this.ontap});

  @override
  Widget build(BuildContext context) {
    String fileType = mediaUrl.path.split('.').last.toLowerCase();

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Stack(
        children: [
          Container(
            height: 75,
            width: 73,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: fileType == 'jpg' ||
                          fileType == 'jpeg' ||
                          fileType == 'png'
                      ? FileImage(mediaUrl)
                      : fileType == 'mp4' || fileType == 'mov'
                          ? NetworkImage(
                              'https://pbs.twimg.com/media/E1ISt3qWYAcTSiX?format=jpg&name=4096x4096')
                          : NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqDQSHxRjP_c9YnQ-wEI2v8Lhk-i-uvyrU2w&s'),
                  fit: BoxFit.cover),
              color: Colors.grey[100],
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Positioned(
              left: 50,
              bottom: 67,
              child: InkWell(
                onTap: ontap,
                child: Icon(
                  Icons.cancel,
                  color: Colors.black,
                  size: 25,
                ),
              )),
        ],
      ),
    );
  }
}
