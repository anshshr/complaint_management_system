import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:share_plus/share_plus.dart';

class FeedbackPage extends StatefulWidget {
  final String username;

  FeedbackPage({required this.username});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  double _rating = 4.0; // Default rating
  TextEditingController _reviewController = TextEditingController();

  void _submitReview() {
    // Handle review submission logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Review submitted!')),
    );
  }

  void _shareReview() {
    String message = "I Rated my Rail Madad App $_rating stars.\n\n"
        "Review: ${_reviewController.text}";

    Share.share(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 32),
          child: Column(
            children: [
              Text(
                "Give Your Feedback & Rating",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                direction: Axis.horizontal,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              SizedBox(height: 24),
              Text(
                '''
                  Hey ${widget.username}   
        Give Your Valuable Feedback Below
             ''',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
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
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 176, 213, 243),
                      minimumSize: Size(150, 50),
                    ),
                    onPressed: _submitReview,
                    icon: Icon(
                      Icons.check,
                      color: Colors.black,
                    ),
                    label: Text(
                      "Submit",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 176, 213, 243),
                      minimumSize: Size(150, 50),
                    ),
                    onPressed: _shareReview,
                    icon: Icon(
                      Icons.share,
                      color: Colors.black,
                    ),
                    label: Text(
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
    );
  }
}
