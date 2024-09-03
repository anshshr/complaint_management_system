import 'package:flutter/material.dart';

class SuggestionPage extends StatelessWidget {
  const SuggestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Suggestion Box
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey.shade400,
                ),
              ),
              child: const TextField(
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Enter your suggestion here...',
                  border: InputBorder.none,
                ),
              ),
            ),
            // Description Box
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(bottom: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey.shade400,
                  ),
                ),
                child: const TextField(
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Enter a detailed description...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            // Action Buttons Row
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.format_bold),
                        onPressed: null,
                      ),
                      IconButton(
                        icon: Icon(Icons.format_italic),
                        onPressed: null,
                      ),
                      IconButton(
                        icon: Icon(Icons.attachment),
                        onPressed: null,
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      // Add functionality to send suggestion
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
