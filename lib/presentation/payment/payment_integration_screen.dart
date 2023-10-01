import 'package:flutter/material.dart';

class PaymentIntegrationScreen extends StatelessWidget {
  const PaymentIntegrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Secure Payment',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Please select a payment method:',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 32.0),
            GestureDetector(
              onTap: () {
                // Handle credit/debit card payment
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.blue,
                ),
                padding: const EdgeInsets.all(16.0),
                child: const Row(
                  children: [
                    Icon(
                      Icons.credit_card,
                      color: Colors.white,
                      size: 32.0,
                    ),
                    SizedBox(width: 16.0),
                    Text(
                      'Credit/Debit Card',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                // Handle digital wallet payment
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.green,
                ),
                padding: const EdgeInsets.all(16.0),
                child: const Row(
                  children: [
                    Icon(
                      Icons.account_balance_wallet,
                      color: Colors.white,
                      size: 32.0,
                    ),
                    SizedBox(width: 16.0),
                    Text(
                      'Digital Wallet',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                // Handle cash on delivery payment
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.orange,
                ),
                padding: const EdgeInsets.all(16.0),
                child: const Row(
                  children: [
                    Icon(
                      Icons.money,
                      color: Colors.white,
                      size: 32.0,
                    ),
                    SizedBox(width: 16.0),
                    Text(
                      'Cash on Delivery',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
