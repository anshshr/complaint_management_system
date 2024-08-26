import 'package:complaint_management_system/components/pages/complaint.dart';
import 'package:complaint_management_system/components/pages/feedback.dart';
import 'package:complaint_management_system/utils/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  final String username;
  final void Function(String languageCode) changeLanguage;

  HomePage({super.key, required this.username, required this.changeLanguage});

  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  final List<String> _pageTitles = [
    'Home Page',
    'Complaint',
    'Feedback Page',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder<int>(
          valueListenable: _currentPage,
          builder: (context, pageIndex, child) {
            return Text(
              _pageTitles[pageIndex],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            );
          },
        ),
        backgroundColor: const Color.fromARGB(255, 69, 155, 225),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              _showLanguageDialog(context);
            },
          ),
        ],
      ),
      drawer: CustomDrawer(username: username),
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
          Center(child: Text(AppLocalizations.of(context)!.homePage)),
          Complaint(),
          FeedbackPage(username: username),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                onTap: () {
                  changeLanguage('en');
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Hindi'),
                onTap: () {
                  changeLanguage('hi');
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
