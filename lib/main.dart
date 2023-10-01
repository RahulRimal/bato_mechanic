import 'package:bato_mechanic/app/managers/route_manager.dart';
import 'package:bato_mechanic/presentation/splash/splash_screen.dart';
import 'package:bato_mechanic/presentation/track_mechanic/track_mechanic_screen.dart';
import 'package:bato_mechanic/presentation/auth/auth_view_model.dart';
import 'package:bato_mechanic/presentation/widgets/map_search/map_search_widget_view_model.dart';
import 'package:bato_mechanic/providers/system_provider.dart';
import 'package:bato_mechanic/providers/theme_provider.dart';
import 'package:bato_mechanic/presentation/request_mechanic/request_mechanic_screen_view_model.dart';
import 'package:bato_mechanic/presentation/splash/splash_screen_view_model.dart';
import 'package:bato_mechanic/presentation/vehicle_category/vehicle_category_screen_view_model.dart';
import 'package:bato_mechanic/presentation/vehicle_repair_request/vehicle_repair_request_view_model.dart';
import 'package:bato_mechanic/presentation/vehicles/vehicle_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/managers/theme_manager.dart';
import 'presentation/vehicle_part/vehicle_parts_screen_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SystemProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SplashScreenViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => MapSearchWidgetViewModel(),
        ),
        ChangeNotifierProvider(
          // create: (_) => VehicleCategoryProvider(),
          create: (_) => VehicleCategoryScreenViewModel(),
        ),
        ChangeNotifierProvider(
          // create: (_) => VehicleProvider(),
          create: (_) => VehiclesScreenViewModel(),
        ),
        ChangeNotifierProvider(
          // create: (_) => VehiclePartProvider(),
          create: (_) => VehiclePartsScreenViewModel(),
        ),
        ChangeNotifierProvider(
          // create: (_) => MechanicProvider(),
          create: (_) => RequestMechanicScreenViewModel(),
        ),
        ChangeNotifierProvider(
          // create: (_) => VehicleRepairRequestProvider(),
          create: (_) => VehicleRepairRequestViewModel(),
        ),
      ],
      child: ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
          builder: (context, _) {
            final themeProvider = Provider.of<ThemeProvider>(context);

            return MaterialApp(
              title: 'Bato Mechanic',

              themeMode: themeProvider.themeMode,
              theme: ThemeManager.lightTheme,
              darkTheme: ThemeManager.darkTheme,
              // home: const SplashScreen(),
              home: TrackMechanicScreen(
                  mechanicName: "Krishna Rimal",
                  estimatedTimeOfArrival: "10 minutes",
                  mechanicLocation: "Baneshwor"),
              onGenerateRoute: RouteGenerator.getRoute,
            );
          }),
    );
  }
}
