import 'package:complaint_management_system/components/pages/Drawer/other_services.dart';
import 'package:complaint_management_system/components/pages/Drawer/settings.dart';
import 'package:complaint_management_system/components/pages/RailAnubhav.dart';
import 'package:complaint_management_system/components/pages/Suggestion.dart';
import 'package:complaint_management_system/components/pages/complaint_pages/complaint.dart';
import 'package:complaint_management_system/components/pages/complaint_pages/complaint_history_page.dart';
import 'package:complaint_management_system/components/pages/complaint_pages/station_complaint.dart';
import 'package:complaint_management_system/components/pages/complaint_pages/track_complaint.dart';
import 'package:complaint_management_system/components/pages/complaint_pages/train_complaint.dart';
import 'package:complaint_management_system/components/pages/feedback.dart';
import 'package:complaint_management_system/components/pages/home_page/home_page.dart';
import 'package:complaint_management_system/components/pages/training%20and%20support/Departent.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];
  final List<String> _routes = [
    'Home',
    'Feedback',
    'Settings',
    'Profile',
    'Complaints',
    'Rail Anubhav',
    'Suggestion',
    'Train Complaint',
    'Station Complaint',
    'Track Complaint',
    'Department',
    'Other Services'
        'Complaint History'
  ];

  void _performSearch(String query) {
    setState(() {
      _searchResults = _routes
          .where((route) => route.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Widget _getScreen(String route) {
    switch (route.toLowerCase()) {
      case 'home':
        return HomePage(
          username: '',
          changeLanguage: (String languageCode) {},
        );
      case 'feedback':
        return FeedbackPage(
          username: '',
        );
      case 'settings':
        return SettingsScreen();
      // case 'profile':
      //   return ProfileScreen();
      case 'complaints':
        return Complaint();
      case 'Rail Anubhav':
        return RailAnubhavPage(
          username: '',
        );
      case 'Suggestion':
        return SuggestionPage();
      case 'Train Complaint':
        return TrainComplaint();
      case 'Station Complaint':
        return StationComplaint();
      case 'Track Complaint':
        return TrackComplaint();
      case 'Department':
        return Department();
      case 'Other Services':
        return OtherServicesPage(
          username: '',
        );
      case 'Complaint History':
        return ComplaintHistoryPage();
      default:
        return HelpScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Helpline Number: 139',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Search Page To Navigate',
                labelStyle: TextStyle(color: Colors.grey[600]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: Colors.black, // Initial border color is black
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: Colors
                        .blue, // Border color changes to blue when focused
                    width: 2.0,
                  ),
                ),
                hintText: 'Type to search...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey[600]),
                  onPressed: () {
                    _searchController.clear();
                    _performSearch(''); // Clear search results
                  },
                ),
              ),
              onChanged: _performSearch,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_searchResults[index]),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) =>
                              _getScreen(_searchResults[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
