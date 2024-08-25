import 'package:complaint_management_system/utils/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Category {
  final String name;
  final String imagePath;
  final String url;

  Category(this.name, this.imagePath, this.url);
}

class OtherServicesPage extends StatelessWidget {
  final String username; // Added username
  final List<Category> categories = [
    Category(
        "Ticket Booking", "assets/logo/irctc.png", "https://www.irctc.co.in"),
    Category("Train Enquiry", "assets/logo/irctcenq.jpeg",
        "https://enquiry.indianrail.gov.in"),
    Category("Reservation Enquiry", "assets/logo/reservationenq.png",
        "https://www.indianrail.gov.in/enquiry/PNR"),
    Category("Retiring Room Booking", "assets/logo/irctctourism.jpg",
        "https://www.irctc.co.in/nget/train-search"),
    Category("Indian Railways", "assets/logo/indianrail.png",
        "https://indianrailways.gov.in"),
    Category("UTS Ticketing", "assets/logo/uts.png",
        "https://www.utsonmobile.indianrail.gov.in"),
  ];

  OtherServicesPage(
      {super.key, required this.username}); // Constructor to pass username

  Future<void> _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Other Services",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        backgroundColor: const Color.fromARGB(255, 69, 155, 225),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo/indianrail.png',
                width: 50, height: 50),
          ),
        ],
      ),
      drawer: CustomDrawer(
        username: username, // Pass username to the drawer
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _launchURL(categories[index].url);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 1.0,
                color: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        categories[index].imagePath,
                        width: 80.0,
                        height: 80.0,
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          categories[index].name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
