import 'package:bato_mechanic/presentation/auth/authentication_screen.dart';
import 'package:bato_mechanic/presentation/feedback_and_contact/feedback_and_contact_screen.dart';
import 'package:bato_mechanic/presentation/payment/payment_integration_screen.dart';
import 'package:bato_mechanic/presentation/reviews_and_rating/rating_and_reviews_screen.dart';
import 'package:bato_mechanic/presentation/request_mechanic/request_mechanic_screen.dart';
import 'package:bato_mechanic/presentation/history/service_history_screen.dart';
import 'package:bato_mechanic/presentation/splash/splash_screen.dart';
import 'package:bato_mechanic/presentation/support_chat/support_chat_screen.dart';
import 'package:bato_mechanic/presentation/temp/temp_screen.dart';
import 'package:bato_mechanic/presentation/vehicle_category/vehicle_category_screen.dart';
import 'package:bato_mechanic/presentation/vehicle_part/vehicle_parts_screen.dart';
import 'package:bato_mechanic/presentation/vehicles/vehicles_screen.dart';
import 'package:flutter/material.dart';

class RoutesManager {
  // static const String splashScreenRoute = '/splash';
  static const String splashScreenRoute = '/';
  static const String authScreenRoute = '/auth';
  static const String feedbackScreen = '/feedback';
  static const String mechanicProfileScreen = '/mechanic-profile';
  static const String paymentIntegrationScreen = '/payment';
  static const String ratingScreen = '/rating';
  static const String requestMechanicScreen = '/request-mechanic';
  static const String serviceHistoryScreen = '/serviceHistory';
  static const String supportChatScreen = '/support-chat';
  static const String trackMechanicScreen = '/track-mechanic';
  static const String vehicleCategoriesScreen = '/vehicle-category';
  static const String vehicleDetailsScreen = '/vehicle-details';
  static const String vehiclePartsScreen = '/vehicle-parts';
  static const String vehiclesScreen = '/vehicle-list';
  static const String tempScreen = '/temp';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutesManager.splashScreenRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RoutesManager.authScreenRoute:
        return MaterialPageRoute(builder: (_) => const AuthenticationScreen());
      case RoutesManager.feedbackScreen:
        return MaterialPageRoute(builder: (_) => const FeedbackContactScreen());
      // case RoutesManager.mechanicsProfileScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => const MechanicP
      //   )
      case RoutesManager.paymentIntegrationScreen:
        return MaterialPageRoute(
            builder: (_) => const PaymentIntegrationScreen());
      case RoutesManager.ratingScreen:
        return MaterialPageRoute(
            builder: (_) => const RatingsAndReviewsScreen());
      case RoutesManager.requestMechanicScreen:
        return MaterialPageRoute(builder: (_) => const RequestMechanicScreen());
      case RoutesManager.serviceHistoryScreen:
        return MaterialPageRoute(builder: (_) => ServiceHistoryScreen());
      case RoutesManager.supportChatScreen:
        return MaterialPageRoute(builder: (_) => const SupportChatScreen());
      case RoutesManager.tempScreen:
        return MaterialPageRoute(builder: (_) => const TempScreen());
      // case RoutesManager.trackMechanicScreen:
      //   return MaterialPageRoute(builder: (_) => TrackMechanicScreen());
      case RoutesManager.vehicleCategoriesScreen:
        return MaterialPageRoute(builder: (_) => const VehicleCategoryScreen());
      // case RoutesManager.vehicleDetailsScreen:
      //   return MaterialPageRoute(builder: (_) => VehiclesScreen());
      case RoutesManager.vehiclePartsScreen:
        return MaterialPageRoute(builder: (_) => const VehiclePartsScreen());
      case RoutesManager.vehiclesScreen:
        return MaterialPageRoute(builder: (_) => const VehiclesScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Undefined Route'),
        ),
        body: const Center(
          child: Text('Undefined Route'),
        ),
      ),
    );
  }
}
