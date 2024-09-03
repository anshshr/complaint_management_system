import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class ComplaintDetails extends StatefulWidget {
  String problem;
  File file;

  ComplaintDetails({super.key, required this.problem, required this.file});

  @override
  State<ComplaintDetails> createState() => _ComplaintDetailsState();
}

class _ComplaintDetailsState extends State<ComplaintDetails> {
  final gemini = Gemini.instance;
  String? solution;
  bool isloaded = false;
  Future<void> GetImage(File file, String problemDesc) async {
    gemini.textAndImage(
        text:
            "Analyze the provided photo to determine if there is any visible garbage or litter at the station. If a problem description is provided, use it to refine your analysis. Based on the identified issues, indicate which department should be notified to address the cleaning. Please provide a detailed response indicating the presence, location of any garbage or litter, and the appropriate department for reporting." +
                problemDesc,

        /// text
        images: [file.readAsBytesSync()]

        /// list of images
        ).then((value) {
      print(value?.content?.parts?.last.text ?? '');
      setState(() {
        solution = value?.content?.parts?.last.text ?? '';
        isloaded = true;
      });
    }).catchError((e) => print(e.toString()));
  }

  @override
  void initState() {
    super.initState();
    GetImage(widget.file, widget.problem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 40, bottom: 20),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.redAccent[100]!,
          Colors.redAccent[200]!,
          Colors.redAccent[100]!,
          Colors.redAccent[200]!,
          Colors.redAccent[100]!,
        ])),
        child: isloaded == true
            ? Card(
                color: Colors.grey[100],
                shadowColor: Colors.grey,
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                  child: Text(
                    solution!.replaceAll('*', ""),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
              )
            : const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.black87,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Loading...',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
