import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:complaint_management_system/components/pages/complaint_pages/train_complaint.dart';
import 'package:complaint_management_system/components/pages/complaint_pages/widgets/media_conatiner.dart';
import 'package:complaint_management_system/utils/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';

class StationComplaint extends StatefulWidget {
  const StationComplaint({super.key});

  @override
  State<StationComplaint> createState() => _StationComplaintState();
}

class _StationComplaintState extends State<StationComplaint> {
  TextEditingController stationname = TextEditingController();
  TextEditingController problem = TextEditingController();
  TextEditingController datetime = TextEditingController();
  File? image;
  File? video;
  File? camera_photo;
  final TextStyle style =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  final picker = ImagePicker();
  List media_type = [];

  late AudioPlayer audioPlayer;
  late AudioRecorder audioRecorder;
  bool isRecording = false;
  // File? audioFile;

  // @override
  // void initState() {
  //   super.initState();
  //   audioPlayer = AudioPlayer();
  //   audioRecorder = AudioRecorder();
  // }

  // Future<void> startRecording() async {
  //   if (await audioRecorder.hasPermission()) {
  //     await audioRecorder.start(path: './audiorecoord', RecordConfig());
  //     setState(() {
  //       isRecording = true;
  //     });
  //   }
  // }

  // Future<void> stopRecording() async {
  //   final path = await audioRecorder.stop();
  //   if (path != null) {
  //     setState(() {
  //       audioFile = File(path);
  //       media_type.add(audioFile);
  //       isRecording = false;
  //     });
  //   }
  // }

  Future<void> show_media_options(BuildContext context) async {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          height: 380,
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 15),
              const Text('SELECT MEDIA',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey)),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                color: Colors.black87,
                thickness: 1,
              ),
              const SizedBox(height: 15),
              InkWell(
                  onTap: () async {
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile == null) return;
                    final path = pickedFile.path;

                    setState(() {
                      image = File(path);
                      media_type.add(image);
                    });
                    Navigator.pop(context);
                  },
                  child: Text('SELECT PHOTO', style: style)),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                color: Colors.black87,
                thickness: 1,
              ),
              const SizedBox(height: 15),
              InkWell(
                  onTap: () async {
                    final pickedFile =
                        await picker.pickVideo(source: ImageSource.gallery);
                    if (pickedFile == null) return;
                    final path = pickedFile.path;

                    setState(() {
                      video = File(path);
                      media_type.add(video);
                    });
                    Navigator.pop(context);
                  },
                  child: Text('SELECT VIDEO', style: style)),
              const SizedBox(height: 15),
              const Divider(
                color: Colors.black87,
                thickness: 1,
              ),
              const SizedBox(height: 15),
              InkWell(
                  onTap: () async {
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.camera);
                    if (pickedFile == null) return;
                    final path = pickedFile.path;

                    setState(() {
                      image = File(path);
                      media_type.add(image);
                    });
                    Navigator.pop(context);
                  },
                  child: Text('OPEN CAMERA', style: style)),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                color: Colors.black87,
                thickness: 1,
              ),
              const SizedBox(height: 15),
              InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: Text('RECORD AUDIO', style: style)),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      padding: const EdgeInsets.all(15),
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
          child: Column(
        children: [
          CustomTextfield(
              hinttext: 'Enter the station name',
              obscurePassword: false,
              labeltext: 'Enter the station name',
              controller: stationname),
          const SizedBox(
            height: 15,
          ),
          CustomTextfield(
              hinttext: 'Enter the date',
              obscurePassword: false,
              labeltext: 'Enter the date  ',
              suffixicon: IconButton(
                  onPressed: () {
                    showDatePicker(
                      cancelText: 'Cancel',
                      confirmText: 'Select Date',
                      context: context,
                      initialDate: DateTime.now(),
                      currentDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2026),
                    ).then((selectedDate) {
                      if (selectedDate != null) {
                        datetime.text = selectedDate.toString().split(' ')[0];
                      }
                    });
                  },
                  icon: const Icon(Icons.calendar_month)),
              controller: datetime),
          const SizedBox(
            height: 15,
          ),
          CustomTextfield(
            hinttext: 'Problem Description',
            obscurePassword: false,
            labeltext: 'Problem description',
            textInputType: TextInputType.multiline,
            maxlines: 7,
            controller: problem,
          ),
          const SizedBox(
            height: 15,
          ),
          media_type.length != 0
              ? SizedBox(
                  height: 90,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: media_type.length,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return MediaConatiner(mediaUrl: media_type[index]);
                    },
                  ),
                )
              : SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              complaint_button('ATTACH FILE', () async {
                await show_media_options(context);
              }),
              const SizedBox(
                width: 20,
              ),
              complaint_button('SUBMIT', () {
                //submit the things
              }),
            ],
          ),
        ],
      )),
    )));
  }
}
