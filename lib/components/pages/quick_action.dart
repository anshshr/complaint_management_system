import 'dart:io' as io;
import 'package:complaint_management_system/components/pages/complaint_pages/complaint.dart';
import 'package:complaint_management_system/components/pages/feedback.dart';
import 'package:complaint_management_system/components/pages/home_page/chat_page.dart';
import 'package:complaint_management_system/components/pages/home_page/home_page_content.dart';
import 'package:complaint_management_system/components/pages/home_page/live_location_page.dart';
import 'package:complaint_management_system/utils/widgets/custom_drawer.dart';
import 'package:complaint_management_system/utils/widgets/language_dailog.dart';
import 'package:flutter/material.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  final String username;

  const HomePage(
      {super.key,
      required this.username,
      required Null Function(String languageCode) changeLanguage});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);
  final QuickActions quickActions = const QuickActions();

  final List<String> _pageTitles = [
    'Home Page',
    'Complaint Page',
    'Feedback Page',
  ];

  @override
  void initState() {
    super.initState();
    initializeQuickActions();
  }

  void initializeQuickActions() {
    quickActions.initialize((shortcutType) {
      if (shortcutType != null) {
        _handleShortcutItemPressed(shortcutType);
      }
    });

    quickActions.setShortcutItems([
      const ShortcutItem(
        type: 'open_complaint',
        localizedTitle: 'Complaint',
        icon: 'icon_complaint',
      ),
      const ShortcutItem(
        type: 'open_website',
        localizedTitle: 'Open Website',
        icon: 'icon_placeholder',
      ),
    ]);
  }

  void _handleShortcutItemPressed(String shortcutType) {
    switch (shortcutType) {
      case 'open_complaint':
        _navigateToPage(1);
        break;
      case 'open_website':
        _launchURL(_buildDynamicURL());
        break;
      default:
        break;
    }
  }

  String _buildDynamicURL() {
    final platform = io.Platform.isAndroid ? "android" : "iOS";
    final url = 'https://rail-madad.vercel.app/';
    return url;
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('Could not launch $url');
    }
  }

  void _navigateToPage(int index) {
    _currentPage.value = index;
    _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define your image paths
    final List<String> imagesLocation = [
      'assets/home/complaint.png',
      'assets/home/urgency.png',
      'assets/home/routing.png',
      'assets/home/setiment.png',
      'assets/home/monitor.webp',
      'assets/home/inquiry.webp',
    ];

    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder<int>(
          valueListenable: _currentPage,
          builder: (context, pageIndex, child) {
            return Text(
              _pageTitles[pageIndex],
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            );
          },
        ),
        backgroundColor: const Color.fromARGB(255, 69, 155, 225),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.language,
              color: Colors.black,
            ),
            onPressed: () {
              showLanguageDialog(context);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.location_on,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LiveLocationPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.chat,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatPage()),
              );
            },
          ),
        ],
      ),
      drawer: CustomDrawer(username: widget.username),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _currentPage,
        builder: (context, pageIndex, child) {
          return BottomNavigationBar(
            currentIndex: pageIndex,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black87,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.compass_calibration),
                label: 'Complaint',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.feedback),
                label: 'Feedback',
              ),
            ],
            onTap: (index) {
              _navigateToPage(index);
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
          HomePageContent(imagesLocation: imagesLocation),
          const Complaint(),
          FeedbackPage(
            username:
                widget.username, /* Ensure the correct username is passed */
          ),
        ],
      ),
    );
  }
}
