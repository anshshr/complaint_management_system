// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutable
import 'package:complaint_management_system/components/pages/home_page/widgets/bot_chat_text.dart';
import 'package:complaint_management_system/components/pages/home_page/widgets/my_chat_text.dart';
import 'package:complaint_management_system/services/api/gemini_services.dart';
import 'package:complaint_management_system/utils/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageContoller = TextEditingController();

  final gemini = Gemini.instance;
  List messages = [];

  Future<void> getanswers(String data) async {
    String geminiReponse = await get_repsonse(data);
    setState(() {
      messages.add(BotChatText(text: geminiReponse));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15).copyWith(top: 40),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: SweepGradient(
          startAngle: 20,
          endAngle: 30,
          colors: [
            Colors.green[100]!,
            Colors.green[200]!,
            Colors.green[100]!,
            Colors.green[200]!,
            Colors.green[100]!,
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
            Align(
              alignment: Alignment.bottomCenter,
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
                          messages.add(MyChatText(text: messageContoller.text));
                          temp = messageContoller.text;
                          messageContoller.text = '';
                        });
                        getanswers(temp);
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.black,
                      )),
                  controller: messageContoller),
            )
          ],
        ),
      ),
    );
  }
}
