// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutable
import 'dart:io';
import 'package:complaint_management_system/components/pages/complaint_pages/widgets/media_conatiner.dart';
import 'package:complaint_management_system/components/pages/home_page/widgets/bot_chat_text.dart';
import 'package:complaint_management_system/components/pages/home_page/widgets/my_chat_text.dart';
import 'package:complaint_management_system/services/api/gemini_services.dart';
import 'package:complaint_management_system/utils/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageContoller = TextEditingController();

  final gemini = Gemini.instance;
  List messages = [];
  List images = [];
  String prompt =
      "You are a helpful assistant for the Shubh Yatra app, designed to assist users with railway-related issues. Your primary role is to guide users through registering complaints about cleanliness, safety, delays, lost items, and more. Additionally, you provide information on services such as train schedules, ticketing, platform locations, and onboard facilities. Help users navigate the app, ensuring they can easily access its features and submit their complaints. Always maintain a polite, friendly tone, and respond clearly and efficiently to ensure users receive the assistance they need.";

  File? image;

  Future<void> getanswers(String data) async {
    String geminiReponse = await get_repsonse(prompt + data);
    setState(() {
      messages.add(BotChatText(text: geminiReponse));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rail Chat Bot',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.blue[400],
      ),
      body: Container(
        padding: EdgeInsets.all(15).copyWith(top: 10, bottom: 10),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: SweepGradient(
          startAngle: 20,
          endAngle: 30,
          colors: [
            Colors.blue[100]!,
            Colors.blue[200]!,
            Colors.blue[100]!,
            Colors.blue[200]!,
            Colors.blue[100]!,
          ],
        )),
        child: Stack(
          children: [
            ListView.builder(
              padding: EdgeInsets.only(bottom: 60),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return messages[index];
              },
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: images.length > 0 ? 170 : 60,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      images.length > 0
                          ? Container(
                              height: 100,
                              child: ListView.builder(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                scrollDirection: Axis.horizontal,
                                itemCount: images.length,
                                itemBuilder: (context, index) {
                                  return MediaConatiner(
                                    mediaUrl: images[index],
                                    ontap: () {
                                      setState(() {
                                        images.removeAt(index);
                                      });
                                    },
                                  );
                                },
                              ),
                            )
                          : SizedBox(),
                      Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              //opne the gallery through the media picker
                              final ImagePicker _picker = ImagePicker();
                              final PickedFile = await _picker.pickImage(
                                  source: ImageSource.gallery);

                              if (PickedFile == null) return;
                              final path = PickedFile.path;
                              setState(() {
                                image = File(path);
                                images.add(image);
                              });
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.black, width: 1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.black87,
                                size: 30,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: CustomTextfield(
                                hinttext: 'Enter you message',
                                obscurePassword: false,
                                labeltext: 'Enter you message',
                                maxlines: 10,
                                textInputType: TextInputType.multiline,
                                suffixicon: IconButton(
                                    onPressed: () async {
                                      String temp = '';
                                      setState(() {
                                        messages.add(MyChatText(
                                          text: messageContoller.text,
                                          images: images,
                                        ));
                                        temp = messageContoller.text;
                                        messageContoller.text = '';
                                        images = [];
                                      });
                                      getanswers(temp);
                                    },
                                    icon: Icon(
                                      Icons.send,
                                      color: Colors.black,
                                    )),
                                controller: messageContoller),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
