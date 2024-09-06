import 'dart:io';
import 'package:complaint_management_system/components/pages/complaint_pages/widgets/media_conatiner.dart';
import 'package:complaint_management_system/services/api/gemini_services.dart';
import 'package:complaint_management_system/services/api/get_image_descripton.dart';
import 'package:complaint_management_system/services/api/train_complaints_api.dart';
import 'package:complaint_management_system/utils/widgets/custom_dialogbox.dart';
import 'package:complaint_management_system/utils/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class TrainComplaint extends StatefulWidget {
  TrainComplaint({super.key});

  @override
  State<TrainComplaint> createState() => _TrainComplaintState();
}

class _TrainComplaintState extends State<TrainComplaint> {
  TextEditingController trainno = TextEditingController();
  TextEditingController berthno = TextEditingController();
  TextEditingController coachno = TextEditingController();
  TextEditingController prno = TextEditingController();
  TextEditingController problem = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController datetime = TextEditingController();
  File? image;
  File? video;
  File? camera_photo;
  File? audioFile;
  final TextStyle style =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  final picker = ImagePicker();
  List media_data = [];
  List<String> media_path = [];

  Future<void> show_bottom_sheet(BuildContext context) async {
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
              const SizedBox(height: 15),
              const Divider(
                color: Colors.black87,
                thickness: 1,
              ),
              const SizedBox(height: 15),
              InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: Text('STOP RECORDING', style: style)),
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
    return Container(
      padding: const EdgeInsets.all(15),
      height: double.infinity,
      width: double.infinity,
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            CustomTextfield(
                hinttext: 'Enter your problem',
                obscurePassword: false,
                labeltext: 'Enter your Problem',
                controller: problem),
            const SizedBox(
              height: 15,
            ),
            CustomTextfield(
                hinttext: 'Enter your Train Name',
                obscurePassword: false,
                labeltext: 'Train Name.',
                textInputType: TextInputType.text,
                controller: trainno),
            const SizedBox(
              height: 15,
            ),
            CustomTextfield(
                hinttext: 'Enter your Berth No',
                obscurePassword: false,
                labeltext: 'Berth no.',
                textInputType: TextInputType.number,
                controller: berthno),
            const SizedBox(
              height: 15,
            ),
            CustomTextfield(
                hinttext: 'Enter your Coach No',
                obscurePassword: false,
                labeltext: 'Coach No',
                textInputType: TextInputType.text,
                controller: coachno),
            const SizedBox(
              height: 15,
            ),
            CustomTextfield(
                hinttext: 'Enter you Train PNR No.',
                obscurePassword: false,
                labeltext: 'PNR No.',
                textInputType: TextInputType.number,
                controller: prno),
            const SizedBox(
              height: 15,
            ),
            CustomTextfield(
                hinttext: 'Enter the date',
                obscurePassword: false,
                textInputType: TextInputType.datetime,
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
              controller: desc,
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
                        return MediaConatiner(mediaUrl: media_data[index]!);
                      },
                    ),
                  )
                : SizedBox(),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                complaint_button('ATTACH FILE', () async {
                  await show_bottom_sheet(context);
                }),
                const SizedBox(
                  width: 20,
                ),
                complaint_button('SUBMIT', () async {
                  //submit the things
                  if (desc.text != null &&
                      problem.text != '' &&
                      desc.text != '' &&
                      prno.text != '') {
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

                    await Future.delayed(Duration(seconds: 15));

                    Navigator.of(context).pop(); // close the dialog
                    String depart_name = media_data.length != 0
                        ? await GetImage(image!,
                            "This is the problem at the station: '${problem.text}'. Please identify the most suitable department for handling this issue from the following list: Engineering Department, Electrical Department, Traffic Department, Medical Department, Security Department, Housekeeping Department, Food Department, Women Safety Department. Provide only one department name exactly as listed.")
                        : await get_repsonse(
                            "This is the problem at the station: '${problem.text}'. Please identify the most suitable department for handling this issue from the following list: Engineering Department, Electrical Department, Traffic Department, Medical Department, Security Department, Housekeeping Department, Food Department, Women Safety Department. Provide only one department name exactly as listed.");
                    print(depart_name.replaceAll("*", ""));
                    //save the data
                    await register_train_complaint(
                        desc.text,
                        coachno.text,
                        int.parse(berthno.text),
                        trainno.text,
                        int.parse(prno.text),
                        datetime.text,
                        media_path,
                        depart_name.replaceAll("*", "").trim(),
                        );
                    //notifying the user
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Your complaint has been registered to the ${depart_name.replaceAll("*", "")}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        backgroundColor: Colors.blue[400],
                      ),
                    );

                    //clearing the fields
                    setState(() {
                      media_data = [];
                      media_path = [];
                      desc.clear();
                      problem.clear();
                      prno.clear();
                      trainno.clear();
                      datetime.clear();
                      berthno.clear();
                      coachno.clear();
                    });
                  } else {
                    customDialog(
                        context, 'Please Enter all the necessary Details');
                  }
                }),
              ],
            )
          ]),
        ),
      )),
    );
  }
}

Widget complaint_button(String text, VoidCallback ontap) {
  return InkWell(
    onTap: ontap,
    child: Container(
      height: 50,
      width: 150,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.blueAccent
            .withOpacity(0.9), // Subtle blue background with opacity
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26, // Subtle shadow effect
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
        gradient: LinearGradient(
          colors: [
            Colors.blueAccent.withOpacity(0.9),
            Colors.lightBlueAccent.withOpacity(0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.white, // White text color for contrast
          ),
        ),
      ),
    ),
  );
}
