import 'package:flutter/material.dart';

class ServiceHistoryScreen extends StatelessWidget {
  // const ServiceHistoryPage({Key? key, required this.serviceRecords})
  //     : super(key: key);
  ServiceHistoryScreen({Key? key}) : super(key: key);

  // final List<ServiceRecord> serviceRecords;
  final List<ServiceRecord> serviceRecords = [
    ServiceRecord(
      date: 'June 1, 2023',
      invoiceNumber: 'INV123456',
      repairDetails: 'Replaced brake pads and adjusted brake system.',
      warrantyInformation: 'Warranty valid for 6 months on parts replaced.',
    ),
    ServiceRecord(
      date: 'March 15, 2023',
      invoiceNumber: 'INV987654',
      repairDetails: 'Performed engine tune-up and oil change.',
      warrantyInformation: 'No warranty available for this service.',
    ),
    // Add more service records as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: serviceRecords.length,
          itemBuilder: (context, index) {
            final serviceRecord = serviceRecords[index];

            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [

                    //   ],
                    // ),
                    Text(
                      'Service Date: ${serviceRecord.date}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Invoice: ${serviceRecord.invoiceNumber}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Repair Details:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      serviceRecord.repairDetails,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Warranty Information:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      serviceRecord.warrantyInformation,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ServiceRecord {
  final String date;
  final String invoiceNumber;
  final String repairDetails;
  final String warrantyInformation;

  ServiceRecord({
    required this.date,
    required this.invoiceNumber,
    required this.repairDetails,
    required this.warrantyInformation,
  });
}
