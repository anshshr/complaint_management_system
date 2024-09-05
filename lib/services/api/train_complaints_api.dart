import 'dart:convert';
import 'package:http/http.dart' as http;

// Function to register a train complaint
Future register_train_complaint(
    String problem_desc,
    String coach_no,
    int berth_no,
    String Trainname,
    int pnrno,
    String date,
    List<String> media,
    String department) async {
  try {
    var train_complaint = {
      'Trainname': Trainname,
      'berth_no': berth_no,
      'coach_no': coach_no,
      'pnrno': pnrno,
      'date': date,
      'problem_desc': problem_desc,
      'department': department,
      'media': media
    };

    var response = await http.post(
      Uri.parse('http://192.168.229.187:3000/api/train_complaint'),
      body: jsonEncode(train_complaint),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Successfully registered train complaint');
      print(jsonDecode(response.body));
    } else {
      print('Failed to register train complaint: ${response.body}');
    }
  } catch (e) {
    print(e.toString());
  }
}

// Function to get train complaints by department name
Future<List<Map<String, dynamic>>> get_train_complaints(
    String dept_name) async {
  try {
    var response = await http.get(Uri.parse(
        'https://complaint-management-system-jgni.onrender.com/api/get_train_complaint_by_dept/$dept_name'));

    if (response.statusCode == 200) {
      print('Successfully fetched train complaints');
      var json_response = json.decode(response.body);
      print(json_response);
      return json_response.cast<Map<String, dynamic>>();
    } else {
      return [
        {'msg': 'No data'}
      ];
    }
  } catch (e) {
    print(e.toString());
    return [
      {'msg': 'Error occurred'}
    ];
  }
}
