import 'dart:io';

import 'package:complaint_management_system/utils/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class TrainComplaint extends StatefulWidget {
  TrainComplaint({super.key});

  @override
  State<TrainComplaint> createState() => _TrainComplaintState();
}

class _TrainComplaintState extends State<TrainComplaint> {
  TextEditingController trainno = TextEditingController();

  TextEditingController prno = TextEditingController();

  TextEditingController problem = TextEditingController();

  TextEditingController desc = TextEditingController();

  TextEditingController datetime = TextEditingController();
  File? image;
  File? video;
  File? camera_photo;
  final TextStyle style = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  final picker = ImagePicker();

  Future<void> show_bottom_sheet(BuildContext context) async {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          height: 300,
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
                    final picked_file =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (picked_file == null) return;

                    setState(() {
                      image = picked_file as File?;
                    });
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
                    final picked_file =
                        await picker.pickVideo(source: ImageSource.gallery);
                    if (picked_file == null) return;

                    setState(() {
                      video = picked_file as File?;
                    });
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
                    final picked_file =
                        await picker.pickImage(source: ImageSource.camera);
                    if (picked_file == null) return;

                    setState(() {
                      image = picked_file as File?;
                    });
                  },
                  child: Text('OPEN CAMERA', style: style)),
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
                hinttext: 'Enter you Train No.',
                obscurePassword: false,
                labeltext: 'Train No.',
                controller: trainno),
            const SizedBox(
              height: 15,
            ),
            CustomTextfield(
                hinttext: 'Enter you Train PRN No.',
                obscurePassword: false,
                labeltext: 'PRN No.',
                controller: prno),
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
                    icon: Icon(Icons.calendar_month)),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                complaint_button('ATTACH FILE', () async {
                  await show_bottom_sheet(context);
                }),
                const SizedBox(
                  width: 20,
                ),
                complaint_button('SUBMIT', () {
                  //submit the things
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
      padding: EdgeInsets.symmetric(horizontal: 10),
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
