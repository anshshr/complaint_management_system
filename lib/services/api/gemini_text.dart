import 'package:flutter_gemini/flutter_gemini.dart';

Future<String> GetGeminiData(String pdf_data) async {
  final gemini = Gemini.instance;
  gemini
      .text(
          "Rate my resume out of 100 for a software developer role according to the basic norms required in it and also suggest some necessary changes in pointwise manner but keep it short as well $pdf_data")
      .then((value) {
    print(value?.content?.parts?.last.text);
    return value?.content?.parts?.last.text;
  })

      /// or value?.content?.parts?.last.text
      .catchError((e) {
    return null;
  });
  return '';
}
