import 'package:complaint_management_system/components/pages/RailAnubhav.dart';
import 'package:complaint_management_system/components/pages/Suggestion.dart';
import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  final String username;

  const FeedbackPage({super.key, required this.username});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: TabBar(
                  indicatorColor: Colors.blue,
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey[600],
                  labelStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  tabs: const [
                    Tab(text: 'Suggestion'),
                    Tab(text: 'Rail Anubhav'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    const SuggestionPage(),
                    RailAnubhavPage(username: widget.username),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
