import 'package:bato_mechanic/screens/feedback_and_contact_screen.dart';
import 'package:bato_mechanic/screens/mechanic_profile_screen.dart';
import 'package:bato_mechanic/screens/rating_and_reviews_screen.dart';
import 'package:bato_mechanic/screens/service_history_screen.dart';
import 'package:bato_mechanic/screens/support_chat_screen.dart';
import 'package:bato_mechanic/screens/track_mechanic_screen.dart';
import 'package:bato_mechanic/screens/vehicle_detail_screen.dart';
import 'package:bato_mechanic/screens/vehicles_screen.dart';
import 'package:flutter/material.dart';

import 'models/vehicle.dart';
import 'screens/authentication_screen.dart';
import 'screens/payment_integration_screen.dart';
import 'screens/request_mechanic_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: const HomeScreen(),
      home: VehiclesScreen(),
      // home: RequestMechanicScreen(),
      // home: MechanicProfileScreen(
      //     mechanicName: 'Sam',
      //     specialization: 'Heavy Machinary',
      //     experience: '3 years',
      //     rating: 4.5,
      //     imagePath: 'assets/images/parts/wheel.png'),
      // home: TrackMechanicScreen(
      //     mechanicName: 'Suman Kanu',
      //     estimatedTimeOfArrival: '10 minutes',
      //     mechanicLocation: 'Muglin Road'),
      // home: AuthenticationScreen(),
      // home: VehicleDetailsScreen(
      //   vehicle: Vehicle(
      //     name: 'Car',
      //     image: 'assets/images/vehicle/car.png',
      //     type: '4 wheeler',
      //     tagLine: 'Small four wheeler',
      //   ),
      // ),
      // home: ServiceHistoryScreen(),
      // home: RatingsAndReviewsScreen(),
      // home: SupportChatScreen(),
      // home: FeedbackContactScreen() ,
      // home: const PaymentIntegrationScreen(),
    );
  }
}
