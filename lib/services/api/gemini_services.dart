import 'package:complaint_management_system/services/api/secrets.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

Future<String> get_repsonse(String question) async {
  try {
    final apiKey = gemini_api_key_value;

    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
    );
    final prompt = question;

    final response = await model.generateContent([Content.text(prompt)]);
    String responseText = response.text!;
    print(response.text);
    return responseText;
  } catch (e) {
    print(e.toString());
    return '';
  }
}
