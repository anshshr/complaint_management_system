import 'dart:convert';
import 'package:http/http.dart' as http;

// Function to register a station complaint
Future<void> station_complaint(String Stationname, int platform_no, String date,
    String problem_desc, String department, List<String> media) async {
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
      Uri.parse(
          'https://complaint-management-system-jgni.onrender.com/api/station_complaint'),
      body: jsonEncode(station_complaint),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Successfully registered the station complaint');
      print(response.body);
    } else {
      print('Failed to register the station complaint: ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

// Function to fetch station complaints by department name
Future<List<Map<String, dynamic>>> fetch_station_complaints(
    String dept_name) async {
  try {
    var response = await http.get(Uri.parse(
        'https://complaint-management-system-jgni.onrender.com/api/get_station_complaint/$dept_name'));

    if (response.statusCode == 200) {
      print('Successfully fetched the station complaints');
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

//get the list of complaints based on the complaint id

Future<List<Map<String, dynamic>>> getstation_complaint_byid(String id) async {
  try {
    var response = await http.get(Uri.parse(
        'https://complaint-management-system-jgni.onrender.com/api/st_complaint/$id'));
    if (response.statusCode == 200) {
      print('Successfully fetched the station complaints');
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
    print('error geting the details of the train');
    print(e.toString());
    return [
      {'msg': 'Error occurred'}
    ];
  }
}
