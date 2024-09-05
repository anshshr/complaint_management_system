import 'dart:convert';

import 'package:http/http.dart' as http;

Future station_complaint(String Stationname,int platform_no, String date, String problem_desc,
    String department, List<String> media) async {
  try {
    var station_complaint = {
      'Stationname': Stationname,
      'platform_no': platform_no,
      'date': date,
      'problem_desc': problem_desc,
      'department': department,
      'media': media
    };

    var response = await http.post(
      Uri.parse('http://192.168.229.187:3000/api/station_complaint'),
      body: jsonEncode(station_complaint),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('succesfully registered the station complaint');
      print(response.body);
    }
  } catch (e) {
    print(e.toString());
  }
}

//get all the station problems
Future<List<Map<String, dynamic>>> fetch_station_complaints(
    String dept_name) async {
  try {
    var response = await http.get(Uri.parse(
        'http://192.168.229.187:3000/api/get_station_complaint/$dept_name'));

    if (response.statusCode == 200) {
      print('succesfully fetched the complaints');
      var json_response = json.decode(response.body);
      print(json_response);
      return json_response.cast<Map<String, dynamic>>();
    } else {
      return [
        {'msg': 'no data'}
      ];
    }
  } catch (e) {
    print(e.toString());
    return [
      {'msg': 'error occured'}
    ];
  }
}
