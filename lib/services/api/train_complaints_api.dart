import 'dart:convert';

import 'package:http/http.dart' as http;

Future register_train_compalint(String problem_desc, String Trainname,
    int pnrno, String date, List<String> media, String department) async {
  try {
    var train_complaint = {
      'Trainname': Trainname,
      'pnrno': pnrno,
      'date': date,
      'problem_desc': problem_desc,
      'department': department,
      'media': media
    };

    var response = await http.post(
      Uri.parse('http://192.168.15.229:3000/api/train_complaint'),
      body: jsonEncode(train_complaint),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('succesfully train compaint registered');
      print(jsonDecode(response.body));
    }
  } catch (e) {
    print(e.toString());
  }
}

//to get the train complaints details by department name

Future<List<Map<String, dynamic>>> get_train_complaints(
    String dept_name) async {
  try {
    var response = await http.get(Uri.parse(
        'http://192.168.15.229:3000/api/get_train_complaint_by_dept/$dept_name'));

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
