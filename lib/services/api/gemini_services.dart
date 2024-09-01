// ignore_for_file: unused_local_variable, avoid_print, dead_code, unnecessary_brace_in_string_interps, non_constant_identifier_names, camel_case_types
import 'dart:convert';
import 'secrets.dart';
import 'package:http/http.dart' as http;

class gemini_api {
  static Future<Map<String, String>> getheader() async {
    return {
      'Content-Type': 'application/json',
    };
  }

  static Future<String> getgeminidata(message) async {
    try {
      final header = await getheader();

      final Map<String, dynamic> requestbody = {
        'contents': [
          {
            'parts': [
              {
                'text': '$message',
              }
            ]
          }
        ],
        'generationConfig': {'temperature': 0.8, 'maxOutputTokens': 1000}
      };

      String url =
          "https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent?key=${gemini_api_key_value}";

      var response = await http.post(Uri.parse(url),
          headers: header, body: jsonEncode(requestbody));
      print(response.body);

      if (response.statusCode == 200) {
        var json_response = jsonDecode(response.body) as Map<String, dynamic>;
        return json_response['candidates'][0]['content']['parts'][0]['text'];
      } else {
        return '';
      }
    } catch (e) {
      return "";
      print('error : $e');
    }
  }
}
