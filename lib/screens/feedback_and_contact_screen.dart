import 'package:flutter/material.dart';

class FeedbackContactScreen extends StatelessWidget {
  const FeedbackContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback and Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'We would love to hear from you!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Please provide your valuable feedback or contact us for any queries or assistance.',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 32.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 16.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Message',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Handle form submission
              },
              child: const Text('Submit'),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'You can also reach us at:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Row(
              children: [
                Icon(Icons.email),
                SizedBox(width: 8.0),
                Text('support@example.com'),
              ],
            ),
            const SizedBox(height: 8.0),
            const Row(
              children: [
                Icon(Icons.phone),
                SizedBox(width: 8.0),
                Text('+1 123-456-7890'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
