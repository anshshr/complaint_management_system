import 'dart:io';
import 'package:complaint_management_system/components/pages/complaint_pages/complaint_details.dart';
import 'package:complaint_management_system/utils/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ParcelInquiry extends StatefulWidget {
  ParcelInquiry({super.key});

  @override
  State<ParcelInquiry> createState() => _ParcelInquiryState();
}

class _ParcelInquiryState extends State<ParcelInquiry> {
  String? selectedType;
  String? selectedSubtype;
  TextEditingController inqdesc = TextEditingController();
  TextEditingController datetime = TextEditingController();
  File? image;
  File? video;
  File? camera_photo;
  final TextStyle style = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  final picker = ImagePicker();

  final List<String> types = ['Type 1', 'Type 2', 'Type 3'];
  final List<String> subtypes = ['Subtype A', 'Subtype B', 'Subtype C'];

  Future<void> show_bottom_sheet(BuildContext context) async {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          height: 320,
          decoration: BoxDecoration(
            color: Colors.blue[800],
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 15),
              const Text(
                'SELECT MEDIA',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              const Divider(
                color: Colors.white54,
                thickness: 1,
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () async {
                  final picked_file =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (picked_file == null) return;
                  final path = picked_file.path;

                  setState(() {
                    image = File(path);
                  });
                },
                child: _buildModalOption('SELECT PHOTO', Icons.photo),
              ),
              const SizedBox(height: 15),
              const Divider(
                color: Colors.white54,
                thickness: 1,
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () async {
                  final picked_file =
                      await picker.pickVideo(source: ImageSource.gallery);
                  if (picked_file == null) return;
                  final path = picked_file.path;

                  setState(() {
                    video = File(path);
                  });
                },
                child: _buildModalOption('SELECT VIDEO', Icons.videocam),
              ),
              const SizedBox(height: 15),
              const Divider(
                color: Colors.white54,
                thickness: 1,
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () async {
                  final picked_file =
                      await picker.pickImage(source: ImageSource.camera);
                  if (picked_file == null) return;
                  final path = picked_file.path;

                  setState(() {
                    image = File(path);
                  });
                },
                child: _buildModalOption('OPEN CAMERA', Icons.camera_alt),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildModalOption(String text, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Parcel Inquiry',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        height: double.infinity,
        width: double.infinity,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Type',
                      border: OutlineInputBorder(),
                    ),
                    value: selectedType,
                    items: types.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedType = newValue;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Sub Type.',
                      border: OutlineInputBorder(),
                    ),
                    value: selectedSubtype,
                    items: subtypes.map((String subtype) {
                      return DropdownMenuItem<String>(
                        value: subtype,
                        child: Text(subtype),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSubtype = newValue;
                      });
                    },
                  ),
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
                            datetime.text =
                                selectedDate.toString().split(' ')[0];
                          }
                        });
                      },
                      icon: Icon(Icons.calendar_month),
                    ),
                    controller: datetime,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextfield(
                    hinttext: 'Inquiry Description',
                    obscurePassword: false,
                    labeltext: 'Inquiry description',
                    textInputType: TextInputType.multiline,
                    maxlines: 7,
                    controller: inqdesc,
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
                        if (selectedType != null && image != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ComplaintDetails(
                                problem: selectedType!,
                                file: image!,
                              ),
                            ),
                          );
                        }
                      }),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
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
        color: Colors.blueAccent.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
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
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
