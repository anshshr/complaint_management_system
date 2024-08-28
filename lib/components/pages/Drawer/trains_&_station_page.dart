import 'package:complaint_management_system/components/pages/Drawer/station_screen.dart';
import 'package:complaint_management_system/components/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:complaint_management_system/components/pages/Drawer/Live_Train_Location.dart';

class TrainStationPage extends StatefulWidget {
  @override
  _TrainStationPageState createState() => _TrainStationPageState();
}

class _TrainStationPageState extends State<TrainStationPage> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          _selectedIndex == 0 ? 'Station' : 'Live Train Status',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HomePage(
                username: '',
                changeLanguage: (String languageCode) {},
              );
            }));
          },
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          StationScreen(),
          TrainTrackingScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.train),
            label: 'Station',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_railway),
            label: 'Live Train Status',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
