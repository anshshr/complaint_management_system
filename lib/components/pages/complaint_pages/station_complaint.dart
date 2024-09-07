import 'dart:io';
import 'package:complaint_management_system/components/pages/complaint_pages/train_complaint.dart';
import 'package:complaint_management_system/components/pages/complaint_pages/widgets/audio_recoder.dart';
import 'package:complaint_management_system/components/pages/complaint_pages/widgets/media_conatiner.dart';
import 'package:complaint_management_system/services/api/gemini_services.dart';
import 'package:complaint_management_system/services/api/get_image_descripton.dart';
import 'package:complaint_management_system/services/api/station_complaints_api.dart';
import 'package:complaint_management_system/utils/widgets/custom_dialogbox.dart';
import 'package:complaint_management_system/utils/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class StationComplaint extends StatefulWidget {
  const StationComplaint({super.key});

  @override
  State<StationComplaint> createState() => _StationComplaintState();
}

class _StationComplaintState extends State<StationComplaint> {
  TextEditingController stationname = TextEditingController();
  TextEditingController platformnumber = TextEditingController();
  TextEditingController problem = TextEditingController();
  TextEditingController datetime = TextEditingController();
  File? image;
  File? video;
  File? camera_photo;
  final TextStyle style =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  final picker = ImagePicker();
  List media_data = [];
  List<String> media_path = [];

  bool isRecording = false;

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
                      media_data.add(image);
                      media_path.add(path);
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
                      media_data.add(video);
                      media_path.add(path);
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
                      media_data.add(image);
                      media_path.add(path);
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecorderScreen()));
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
              hinttext: 'Enter the Platform number',
              obscurePassword: false,
              labeltext: 'Enter the Platform number',
              textInputType: TextInputType.number,
              controller: platformnumber),
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
          media_data.length != 0
              ? SizedBox(
                  height: 90,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: media_data.length,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return MediaConatiner(
                        mediaUrl: media_data[index],
                        ontap: () {
                          setState(() {
                            media_data.removeAt(index);
                            media_path.removeAt(index);
                          });
                        },
                      );
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
              complaint_button('SUBMIT', () async {
                if (stationname.text != '' &&
                    stationname.text != null &&
                    problem.text != "" &&
                    problem.text != null &&
                    platformnumber.text != "" &&
                    platformnumber.text != null) {
                  // Display animation
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Lottie.network(
                                'https://lottie.host/d2a9cfb9-8191-46f2-bc91-c3e488327d7b/4EvUuhLA0L.json',
                                width: double.infinity,
                                height: 400),
                            SizedBox(height: 10),
                            Text(
                              'Registering complaint...',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );

                  String depart_name = media_data.length != 0
                      ? await GetImage(image!,
                          "This is the problem at the station: '${problem.text}'. Please identify the most suitable department for handling this issue from the following list: Engineering Department, Electrical Department, Traffic Department, Medical Department, Security Department, Housekeeping Department, Food Department, Women Safety Department. Provide only one department name exactly as listed.")
                      : await get_repsonse(
                          "This is the problem at the station: '${problem.text}'. Please identify the most suitable department for handling this issue from the following list: Engineering Department, Electrical Department, Traffic Department, Medical Department, Security Department, Housekeeping Department, Food Department, Women Safety Department. Provide only one department name exactly as listed.");
                  print(depart_name.replaceAll("*", ""));
                  await station_complaint(
                      stationname.text,
                      int.parse(platformnumber.text),
                      datetime.text,
                      problem.text,
                      depart_name.replaceAll("*", ""),
                      media_path);
                  Navigator.of(context).pop(); // close the dialog

                  //notifying the user
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Your complaint has been registered to the ${depart_name.replaceAll("*", "")}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      backgroundColor: Colors.blue[400],
                    ),
                  );

                  //clearing the fields
                  setState(() {
                    media_data = [];
                    media_path = [];
                    problem.clear();
                    datetime.clear();
                    stationname.clear();
                    platformnumber.clear();
                  });
                } else {
                  customDialog(context, 'Please fill all the details');
                }
              }),
            ],
          ),
        ],
      )),
    )));
  }
}
