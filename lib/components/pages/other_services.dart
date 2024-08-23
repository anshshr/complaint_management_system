import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void _launchURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}

class Category {
  final String name;
  final String imagePath;

  final String url;

  Category(this.name, this.imagePath, this.url);
}

class OtherServicesPage extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Other Services"),
        leading:const Icon(Icons.arrow_back),
        backgroundColor: Colors.blue,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo/irctcenq.png'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:  GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _launchURL(categories[index].url),
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
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 13.0,
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
