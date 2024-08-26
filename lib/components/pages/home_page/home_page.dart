import 'package:complaint_management_system/components/pages/complaint_pages/complaint.dart';
import 'package:complaint_management_system/components/pages/feedback.dart';
import 'package:complaint_management_system/utils/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String username;

  HomePage({super.key, required this.username});

  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  final List<String> _pageTitles = [
    'Home Page',
    'Complaint Page',
    'Feedback Page',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _currentPage,
        builder: (context, pageIndex, child) {
          return BottomNavigationBar(
            currentIndex: pageIndex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.black87,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.compass_calibration,
                  color: Colors.black87,
                ),
                label: 'Complaint',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.feedback,
                  color: Colors.black87,
                ),
                label: 'Feedback',
              ),
            ],
            onTap: (index) {
              _currentPage.value = index;
              _pageController.jumpToPage(index);
            },
          );
        },
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          _currentPage.value = index;
        },
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text(
                'Home Page',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              backgroundColor: const Color.fromARGB(255, 69, 155, 225),
            ),
            drawer: CustomDrawer(username: username),
            body: Center(
              child: Text('Home Page'),
            ),
          ),
          const Complaint(),
          FeedbackPage(username: username),
        ],
      ),
    );
  }
}
