import 'dart:io';

import 'package:complaint_management_system/components/pages/complaint_pages/train_complaint.dart';
import 'package:complaint_management_system/utils/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
        TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    final picker = ImagePicker();

  Future<void> show_media_options(BuildContext context) async {
   
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
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile == null) return;

                    setState(() {
                      image = pickedFile as File?;
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
                    final pickedFile =
                        await picker.pickVideo(source: ImageSource.gallery);
                    if (pickedFile == null) return;

                    setState(() {
                      video = pickedFile as File?;
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
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.camera);
                    if (pickedFile == null) return;

                    setState(() {
                      image = pickedFile as File?;
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
    return Scaffold(
        body: Center(
            child: Container(
      padding: EdgeInsets.all(15),
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
                      onDatePickerModeChange: (value) {
                        datetime.text = value as String;
                      },
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
            controller: problem,
          ),
          const SizedBox(
            height: 15,
          ),
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
          )
        ],
      )),
    )));
  }
}

