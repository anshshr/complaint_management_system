// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class RolesResponsibilities extends StatefulWidget {
  String deptName;
  RolesResponsibilities({
    super.key,
    required this.deptName,
  });

  @override
  State<RolesResponsibilities> createState() => _RolesResponsibilitiesState();
}

class _RolesResponsibilitiesState extends State<RolesResponsibilities> {
  String? res;
  bool isloaded = false;
  Future getResponsibilities(String name) async {
    final gemini = Gemini.instance;

    gemini
        .text(
            "You are the station master at a busy railway station. Your task is to explain the roles and responsibilities of various railway departments in a clear,simple and detailed manner. For each department, provide an easy-to-understand description of what they do and how they contribute to the smooth operation of the railway station. Be concise and make sure the information is accessible to everyone, even those with no prior knowledge of the railway system, and the department name is${widget.deptName}")
        .then((value) {
      print(value?.output);
      setState(() {
        res = value?.output!.replaceAll('*', ' ');

        isloaded = true;
      });
    })

        /// or value?.content?.parts?.last.text
        .catchError((e) => print(e.toString()));
  }

  @override
  void initState() {
    super.initState();
    getResponsibilities(widget.deptName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.only(top: 40),
          height: double.infinity,
          width: double.infinity,
          color: Colors.red[100],
          child: isloaded == true
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        '${widget.deptName} Roles and Responsibilities',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Card(
                        margin: const EdgeInsets.only(
                            bottom: 20, left: 20, right: 20),
                        color: Colors.grey[100],
                        shadowColor: Colors.grey[100],
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 20),
                          child: Text(
                            textAlign: TextAlign.left,
                            res ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      )
                    ],
                  ),
                )),
    );
  }
}
