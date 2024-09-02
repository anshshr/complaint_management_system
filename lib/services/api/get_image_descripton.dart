import 'dart:io';

import 'package:flutter_gemini/flutter_gemini.dart';

Future<String> GetImage(File file, String problemDesc) async {
  final gemini = Gemini.instance;
  try {
    final value = await gemini.textAndImage(
        text:
            " Based on the identified issues, indicate which department should be notified to address the cleaning.Please identify the most suitable department for handling this issue from the following list: Engineering Department, Electrical Department, Traffic Department, Medical Department, Security Department, Housekeeping Department, Food Department. Provide only one department name exactly as listed. write only departname and nothing else" +
                problemDesc,

        /// text
        images: [file.readAsBytesSync()]

        /// list of images
        );
    return value?.content?.parts?.last.text ?? '';
  } catch (e) {
    print(e.toString());
    return '';
  }
}
