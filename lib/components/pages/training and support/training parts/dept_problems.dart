// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:complaint_management_system/services/api/station_complaints_api.dart';
import 'package:complaint_management_system/services/api/train_complaints_api.dart';
import 'package:flutter/material.dart';

class DeptProblems extends StatefulWidget {
  String deptname;
  DeptProblems({
    super.key,
    required this.deptname,
  });

  @override
  State<DeptProblems> createState() => _DeptProblemsState();
}

class _DeptProblemsState extends State<DeptProblems> {
  List<Map<String, dynamic>> train_data = [];
  List<Map<String, dynamic>> station_data = [];

  Future get_train_problems() async {
    List<Map<String, dynamic>> api_data =
        await get_train_complaints(widget.deptname);

    for (Map<String, dynamic> d in api_data) {
      train_data.add(d);
    }
    setState(() {});
    print('printing train complaints data');
    print(train_data);
  }

  Future get_station_problems() async {
    List<Map<String, dynamic>> api_data =
        await fetch_station_complaints(widget.deptname);

    for (Map<String, dynamic> d in api_data) {
      station_data.add(d);
    }
    setState(() {});
    print('printing station complaints data');
    print(station_data);
  }

  @override
  void initState() {
    super.initState();
    get_train_problems();
    get_station_problems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.only(top: 40),
          height: double.infinity,
          width: double.infinity,
          color: Colors.red[100],
          child: Column(
            children: [
              Text(
                textAlign: TextAlign.center,
                '${widget.deptname} Problems',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              ListTile(
                title: Text(
                  'Train complaints',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: train_data.length != 0
                    ? Card(
                        elevation: 2,
                        color: Colors.grey[100],
                        shadowColor: Colors.grey[100],
                        child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: train_data.length,
                          itemBuilder: (context, outerindex) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(train_data[outerindex]['Trainname'] ?? ''),
                                Text(train_data[outerindex]['date'] ?? ''),
                                Text(train_data[outerindex]['pnrno'].toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(train_data[outerindex]['problem_desc'] ??
                                    ''),
                              ],
                            );
                          },
                        ))
                    : Container(
                        child: Text('No train data available'),
                      ),
              ),
              ListTile(
                  title: Text(
                    'Station complaints',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: station_data.length != 0
                      ? Card(
                          elevation: 2,
                          color: Colors.grey[100],
                          shadowColor: Colors.grey[100],
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: station_data.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Text(station_data[index]['Stationname']),
                                  Text(station_data[index]['date']),
                                  Text(station_data[index]['problem_desc']),
                                ],
                              );
                            },
                          ),
                        )
                      : Container(
                          child: Text('No station data available'),
                        ))
            ],
          )),
    );
  }
}
