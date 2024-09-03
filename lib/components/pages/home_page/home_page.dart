import 'dart:io' as io;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:complaint_management_system/components/pages/complaint_pages/complaint.dart';
import 'package:complaint_management_system/components/pages/complaint_pages/complaint_history_page.dart';
import 'package:complaint_management_system/components/pages/feedback.dart';
import 'package:complaint_management_system/components/pages/home_page/chat_page.dart';
import 'package:complaint_management_system/components/pages/home_page/home_page_content.dart';
import 'package:complaint_management_system/components/pages/home_page/live_location_page.dart';
import 'package:complaint_management_system/provider/language_provider.dart';
import 'package:complaint_management_system/utils/widgets/custom_drawer.dart';
import 'package:complaint_management_system/utils/widgets/language_dailog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        icon: 'indianrail',
      ),
      const ShortcutItem(
        type: 'open_website',
        localizedTitle: 'Open Website',
        icon: 'indianrail',
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
            username: widget.username,
          ),
        ],
      ),
    );
  }

  List images_location = [
    'assets/home/complaint.png',
    'assets/home/urgency.png',
    'assets/home/routing.png',
    'assets/home/setiment.png',
    'assets/home/monitor.webp',
    'assets/home/inquiry.webp',
  ];

  late List<Widget> images = [
    customSliderConatiner(0, 'Automated Complaint system', Colors.blue[200]!,
        ' AI categorizes complaints from images, videos, or audio.'),
    customSliderConatiner(1, 'Urgency Detection', Colors.blue[100]!,
        'AI assesses and prioritizes urgent issues from visual content. '),
    customSliderConatiner(2, 'Smart Routing', Colors.blue[100]!,
        ' Routes complaints to relevant departments using AI algorithms.'),
    customSliderConatiner(3, 'Sentiment Analysis:', Colors.blue[100]!,
        'Analyzes feedback sentiment to identify improvement areas. '),
    customSliderConatiner(4, 'Speed Analysis:', Colors.blue[100]!,
        'Monitors registration and resolution speed to improve efficiency.'),
    customSliderConatiner(5, 'Railway Inquiry', Colors.blue[100]!,
        'Our app offers the inquiry about various railway depart and their problems ')
  ];

  Widget homepage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Stack(
        children: [
          Column(
            children: [
              CarouselSlider(
                  items: images,
                  options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayAnimationDuration: const Duration(seconds: 3),
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      height: 200,
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      enlargeFactor: 1,
                      viewportFraction: 0.95,
                      animateToClosest: true,
                      disableCenter: true,
                      pauseAutoPlayOnTouch: true)),
              SolvedComplaintsTab(),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          image: NetworkImage(
                              'https://www.shutterstock.com/image-illustration/3d-illustration-little-robot-fat-260nw-1640636815.jpg')),
                      border: Border.all(width: 2, color: Colors.black87),
                      borderRadius: BorderRadius.circular(40)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget customSliderConatiner(
      int index, String title, Color color, String descText) {
    return Container(
      height: 500,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(.7),
              color.withOpacity(.5),
              color.withOpacity(.3),
              color.withOpacity(.1),
            ]),
        border: Border.all(width: 2, color: Colors.black87),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
          ),
          SizedBox(
            height: 110,
            width: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                images_location[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            descText,
            style: const TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(color: Colors.blue, width: 2.0),
          ),
          shadowColor: Colors.blue,
          title: const Text(
            'Choose Language',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text(
                  'English',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blue),
                ),
                onTap: () {
                  Provider.of<LanguageProvider>(context, listen: false)
                      .setLocale(const Locale('en'));
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text(
                  'Hindi',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 20),
                ),
                onTap: () {
                  Provider.of<LanguageProvider>(context, listen: false)
                      .setLocale(const Locale('hi'));
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
