import 'dart:async';
import 'package:complaint_management_system/components/pages/register_page.dart';
import 'package:flutter/material.dart';

class IntroductoryPages extends StatefulWidget {
  @override
  _IntroductoryPagesState createState() => _IntroductoryPagesState();
}

class _IntroductoryPagesState extends State<IntroductoryPages> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 3) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: <Widget>[
              buildPage(
                assetPath: 'assets/into/page1.jpg',
                text: "",
              ),
              buildPage(
                assetPath: 'assets/into/page2.jpg',
                text: "",
              ),
              buildPage(
                assetPath: 'assets/into/page3.jpg',
                text: "",
              ),
              buildPage(
                assetPath: 'assets/into/page4.jpg',
                text: "",
                showButton: true,
              ),
            ],
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return buildDot(index: index);
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage({
    required String assetPath,
    required String text,
    bool showButton = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[400],
        image: DecorationImage(
          image: AssetImage(assetPath),
          fit: BoxFit.contain,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            if (showButton)
              Padding(
                padding: const EdgeInsets.only(bottom: 90.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 13),
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  child: Text("Get Started"),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildDot({required int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 10,
      width: _currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue : Colors.black,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
