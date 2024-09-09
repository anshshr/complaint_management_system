import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageTextRecognizer extends StatefulWidget {
  const ImageTextRecognizer({super.key});

  @override
  _ImageTextRecognizerState createState() => _ImageTextRecognizerState();
}

class _ImageTextRecognizerState extends State<ImageTextRecognizer> {
  File? _image;
  String? _recognizedText;
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImageAndDetectText() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      setState(() {
        _image = imageFile;
      });
      String text = await _getImageToText(pickedFile.path);
      setState(() {
        _recognizedText = text;
      });
    }
  }

  Future<String> _getImageToText(String imagePath) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(InputImage.fromFilePath(imagePath));
    return recognizedText.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: const Text(
          'Text Recognition',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (_image != null)
                  Container(
                      height: 300, width: 300, child: Image.file(_image!)),
                if (_recognizedText != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectableText(
                      _recognizedText!,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: _getImageAndDetectText,
                  child: const Text(
                    'Select Image and Detect Text',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                if (_recognizedText != null)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: _recognizedText!));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Text copied to clipboard')),
                      );
                    },
                    child: const Text('Copy Recognized Text'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
