import 'package:bato_mechanic/models/session.dart';
import 'package:bato_mechanic/screens/managers/route_manager.dart';
import 'package:bato_mechanic/view_models/base_view_model.dart';
import 'package:bato_mechanic/view_models/providers/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenViewModel extends SessionProvider with BaseViewModel {
  init(BuildContext context) async {
    initViewModels(context);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String accessToken = preferences.getString('accessToken') ?? '';
    if (accessToken.isNotEmpty) {
      if (!await super.getPreviousSession(accessToken)) {
        Navigator.of(context)
            .pushReplacementNamed(RoutesManager.vehicleCategoriesScreen);
      } else {
        // Getting previous session fail means the access token has been expired so use the refresh token to refresh the session
        String refreshToken = preferences.getString('refreshToken') ?? '';
        if (refreshToken.isNotEmpty) {
          if (await super.refreshSession(refreshToken)) {
            Navigator.of(context)
                .pushReplacementNamed(RoutesManager.vehicleCategoriesScreen);
          }
        }
        // If refresh is empty then redirect to login screen
        Navigator.of(context)
            .pushReplacementNamed(RoutesManager.authScreenRoute);
      }
    } else {
      String refreshToken = preferences.getString('refreshToken') ?? '';
      if (refreshToken.isNotEmpty) {
        if (await super.refreshSession(refreshToken)) {
          Navigator.of(context)
              .pushReplacementNamed(RoutesManager.vehicleCategoriesScreen);
        }
      }
      // If refresh is empty then redirect to login screen
      Navigator.of(context).pushReplacementNamed(RoutesManager.authScreenRoute);
    }
  }
}
