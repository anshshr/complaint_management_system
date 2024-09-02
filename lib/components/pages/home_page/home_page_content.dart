import 'package:carousel_slider/carousel_slider.dart';
import 'package:complaint_management_system/components/pages/complaint_pages/complaint_history_page.dart';
import 'package:flutter/material.dart';
import 'package:complaint_management_system/utils/widgets/custom_slider_container.dart';

class HomePageContent extends StatelessWidget {
  final List<String> imagesLocation;

  const HomePageContent({Key? key, required this.imagesLocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> images = [
      customSliderContainer(
          0,
          'Automated Complaint System',
          Colors.blue[200]!,
          'AI categorizes complaints from images, videos, or audio.',
          imagesLocation[0]),
      customSliderContainer(
          1,
          'Urgency Detection',
          Colors.blue[100]!,
          'AI assesses and prioritizes urgent issues from visual content.',
          imagesLocation[1]),
      customSliderContainer(
          2,
          'Smart Routing',
          Colors.blue[100]!,
          'Routes complaints to relevant departments using AI algorithms.',
          imagesLocation[2]),
      customSliderContainer(
          3,
          'Sentiment Analysis',
          Colors.blue[100]!,
          'Analyzes feedback sentiment to identify improvement areas.',
          imagesLocation[3]),
      customSliderContainer(
          4,
          'Speed Analysis',
          Colors.blue[100]!,
          'Monitors registration and resolution speed to improve efficiency.',
          imagesLocation[4]),
      customSliderContainer(
          5,
          'Railway Inquiry',
          Colors.blue[100]!,
          'Our app offers inquiry about various railway departments and their problems.',
          imagesLocation[5]),
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          children: [
            CarouselSlider(
              items: images,
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration: const Duration(milliseconds: 1500),
                initialPage: 0,
                enableInfiniteScroll: true,
                height: 220,
                scrollDirection: Axis.horizontal,
                reverse: false,
                enlargeFactor: 1,
                viewportFraction: 0.95,
                animateToClosest: true,
                disableCenter: true,
                pauseAutoPlayOnTouch: true,
              ),
            ),
            const SizedBox(height: 20),
            SolvedComplaintsTab(),
          ],
        ),
      ),
    );
  }
}
