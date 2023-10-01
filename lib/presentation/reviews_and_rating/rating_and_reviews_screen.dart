import 'package:flutter/material.dart';

class RatingsAndReviewsScreen extends StatefulWidget {
  const RatingsAndReviewsScreen({super.key});

  @override
  State<RatingsAndReviewsScreen> createState() =>
      _RatingsAndReviewsScreenState();
}

class _RatingsAndReviewsScreenState extends State<RatingsAndReviewsScreen> {
  final double _rating = 0;
  String _review = '';

  void _submitReview() {
    // Implement logic to submit the review
    // You can store the rating and review in a database or perform other actions
    // Here, we just print the values for demonstration purposes
    print('Rating: $_rating');
    print('Review: $_review');

    // Show a success message or navigate to a different screen
    // ...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ratings and Reviews'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rate the mechanic',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 40,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 40,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 40,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 40,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 40,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Write a review',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              maxLines: 3,
              onChanged: (value) {
                setState(() {
                  _review = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your review here',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitReview,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
