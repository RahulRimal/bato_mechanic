import 'package:bato_mechanic/screens/feedback_and_contact_screen.dart';
import 'package:bato_mechanic/screens/mechanic_profile_screen.dart';
import 'package:bato_mechanic/screens/rating_and_reviews_screen.dart';
import 'package:bato_mechanic/screens/service_history_screen.dart';
import 'package:bato_mechanic/screens/support_chat_screen.dart';
import 'package:bato_mechanic/screens/temp_screen.dart';
import 'package:bato_mechanic/screens/track_mechanic_screen.dart';
import 'package:bato_mechanic/screens/vehicle_detail_screen.dart';
import 'package:bato_mechanic/screens/vehicle_category_screen.dart';
import 'package:bato_mechanic/view_models/providers/map_provider.dart';
import 'package:bato_mechanic/view_models/providers/mechanic_provider.dart';
import 'package:bato_mechanic/view_models/providers/vehicle_category_provider.dart';
import 'package:bato_mechanic/view_models/providers/vehicle_part_provider.dart';
import 'package:bato_mechanic/view_models/providers/vehicle_provider.dart';
import 'package:bato_mechanic/widgets/map_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MapProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => VehicleCategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => VehicleProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => VehiclePartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MechanicProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),

        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        // home: const HomeScreen(),
        home: VehicleCategoryScreen(),
        // home: Scaffold(body: MapSearchWidget()),
        // home: TempScreen(),
        // home: MechanicProfileScreen(
        //     mechanicName: 'Sam',
        //     specialization: 'Heavy Machinary',
        //     experience: '3 years',
        //     rating: 4.5,
        //     imagePath: 'assets/images/parts/wheel.png'),
        // home: RequestMechanicScreen(),

        // home: RequestMechanicScreen(),
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
      ),
    );
  }
}
