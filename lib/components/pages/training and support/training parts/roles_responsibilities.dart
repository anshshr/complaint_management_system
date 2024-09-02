import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:lottie/lottie.dart';

class RolesResponsibilities extends StatefulWidget {
  final String deptName;
  const RolesResponsibilities({
    super.key,
    required this.deptName,
  });

  @override
  State<RolesResponsibilities> createState() => _RolesResponsibilitiesState();
}

class _RolesResponsibilitiesState extends State<RolesResponsibilities> {
  String? res;
  bool isLoaded = false;

  Future getResponsibilities(String name) async {
    final gemini = Gemini.instance;

    gemini
        .text(
            "You are the station master at a busy railway station. Your task is to explain the roles and responsibilities of various railway departments in a clear, simple, and detailed manner. For each department, provide an easy-to-understand description of what they do and how they contribute to the smooth operation of the railway station. Be concise and make sure the information is accessible to everyone, even those with no prior knowledge of the railway system. The department name is ${widget.deptName}")
        .then((value) {
      setState(() {
        res = value?.output?.replaceAll('*', ' ');
        isLoaded = true;
      });
    }).catchError((e) => print(e.toString()));
  }

  @override
  void initState() {
    super.initState();
    getResponsibilities(widget.deptName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.deptName}',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.blue[400],
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.blue[50],
        child: isLoaded
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Roles and Responsibilities',
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      shadowColor: Colors.blue[200],
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          res ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/animation/dept1.json',
                        height: 200, width: 200),
                    const SizedBox(height: 20),
                    const Text(
                      'Loading, please wait...',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
