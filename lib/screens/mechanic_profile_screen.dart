import 'package:flutter/material.dart';

class MechanicProfileScreen extends StatelessWidget {
  final String mechanicName;
  final String specialization;
  final String experience;
  final double rating;
  final String imagePath;

  const MechanicProfileScreen({
    Key? key,
    required this.mechanicName,
    required this.specialization,
    required this.experience,
    required this.rating,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mechanic Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mechanicName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    specialization,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Experience: $experience years',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Row(
                        children: List.generate(
                              rating.floor(),
                              (index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 20,
                              ),
                            ) +
                            (rating % 1 > 0
                                ? [
                                    Icon(
                                      Icons.star_half,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                  ]
                                : []),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
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
