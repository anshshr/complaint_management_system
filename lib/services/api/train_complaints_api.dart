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
      Uri.parse(
          'https://complaint-management-system-jgni.onrender.com/api/train_complaint'),
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


//get the train complaints by the complaint id

Future<List<Map<String,dynamic>>> get_train_complaint_byid(String id) async {
  try {
    var response = await http.get(Uri.parse(
        'https://complaint-management-system-jgni.onrender.com/api/tr_complaint/$id'));
    if (response.statusCode == 200) {
      print('Successfully fetched the train complaints');
      var json_response = json.decode(response.body);
      print(json_response);
      return json_response.cast<Map<String, dynamic>>();
    } else {
      print('Failed to fetch complaints: ${response.body}');
      return [
        {'msg': 'No data available'}
      ];
    }
  } catch (e) {
    print('Error: $e');
    return [
      {'msg': 'Error occurred'}
    ];
  }
}