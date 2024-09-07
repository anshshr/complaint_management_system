import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String?> getUpcomingStation(String trainNumber) async {
  final url = 'https://rappid.in/apis/train.php?train_no=$trainNumber';
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['success'] == true) {
        List<dynamic>? stations = data['data'];
        if (stations != null) {
          print('Stations data retrieved successfully: $stations');

          // Find the next station where is_current_station is false
          for (var station in stations) {
            if (station is Map<String, dynamic> && station['is_current_station'] == false) {
              print('Upcoming station found: ${station['station_name']}');
              return station['station_name'];
            }
          }
          print('No upcoming station found.');
        } else {
          print('Data field "data" is not a list.');
        }
      } else {
        print('API response indicates failure: ${data['message']}');
      }
    } else {
      print('HTTP error: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching upcoming station: $e');
  }
  return null;
}
