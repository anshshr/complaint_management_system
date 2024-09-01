import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';

class RailAnubhavPage extends StatefulWidget {
  final String username;

  const RailAnubhavPage({super.key, required this.username});

  @override
  _RailAnubhavPageState createState() => _RailAnubhavPageState();
}

class _RailAnubhavPageState extends State<RailAnubhavPage> {
  double _rating = 4.0;
  final TextEditingController _reviewController = TextEditingController();
  String sentiment = '';
  bool _isLoading = false;

  void _submitReview() async {
    String reviewText = _reviewController.text.trim();

    if (reviewText.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      final url = Uri.https('models3.p.rapidapi.com', '/');
      final queryParameters = {
        'model_id': '27',
        'prompt':
            'Analyze review and only give response that the user is satisfy with the app in exactly 10 words: $reviewText',
      };
      final headers = {
        'Content-Type': 'application/json',
        'X-RapidAPI-Key': 'cddc497c61msha056b75bbe92f88p1c3834jsn007efcd6ece0',
        'X-RapidAPI-Host': 'models3.p.rapidapi.com',
      };
      final body = jsonEncode({
        'key1': 'value',
        'key2': 'value',
      });

      final response = await http.post(
        url.replace(queryParameters: queryParameters),
        headers: headers,
        body: body,
      );

      setState(() {
        _isLoading = false; // Hide loading indicator

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          sentiment = responseData['content'].replaceAll("\n", "");
        } else {
          sentiment = 'Error analyzing sentiment';
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.blue,
          content: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: sentiment,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          duration: Duration(seconds: 6),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please write a review before submitting.'),
          duration: Duration(seconds: 6),
        ),
      );
    }

    _reviewController.clear();
  }

  void _shareReview() {
    String message = "I Rated my Rail Madad App $_rating stars.\n\n"
        "Review: ${_reviewController.text}\n\n"
        "Response: $sentiment";

    Share.share(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 32),
              child: Column(
                children: [
                  const Text(
                    "Give Your Feedback & Rating",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  RatingBar.builder(
                    initialRating: _rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Hey ${widget.username}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Give Your Valuable Feedback Below',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _reviewController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Write your message here ...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 176, 213, 243),
                          minimumSize: const Size(150, 50),
                        ),
                        onPressed: _submitReview,
                        icon: const Icon(
                          Icons.check,
                          color: Colors.black,
                        ),
                        label: const Text(
                          "Submit",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 176, 213, 243),
                          minimumSize: const Size(150, 50),
                        ),
                        onPressed: _shareReview,
                        icon: const Icon(
                          Icons.share,
                          color: Colors.black,
                        ),
                        label: const Text(
                          "Share",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Center(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white.withOpacity(0.9),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/animation/train1.json'),
                    Text(
                      'On Track, Almost there ...',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
