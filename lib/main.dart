import 'package:bato_mechanic/screens/managers/route_manager.dart';
import 'package:bato_mechanic/screens/splash_screen.dart';
import 'package:bato_mechanic/view_models/auth_view_model.dart';
import 'package:bato_mechanic/view_models/map_search_widget_view_model.dart';
import 'package:bato_mechanic/view_models/providers/system_provider.dart';
import 'package:bato_mechanic/view_models/providers/theme_provider.dart';
import 'package:bato_mechanic/view_models/request_mechanic_screen_view_model.dart';
import 'package:bato_mechanic/view_models/splash_screen_view_model.dart';
import 'package:bato_mechanic/view_models/vehicle_category_screen_view_model.dart';
import 'package:bato_mechanic/view_models/vehicle_repair_request_view_model.dart';
import 'package:bato_mechanic/view_models/vehicle_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/managers/theme_manager.dart';
import 'view_models/vehicle_parts_screen_view_model.dart';

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
              // theme: ThemeData(
              //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              //   useMaterial3: true,
              // ),
              themeMode: themeProvider.themeMode,
              // themeMode: ThemeMode.system,
              theme: ThemeManager.lightTheme,
              darkTheme: ThemeManager.darkTheme,
              home: const SplashScreen(),
              onGenerateRoute: RouteGenerator.getRoute,
            );
          }),
    );
  }
}
