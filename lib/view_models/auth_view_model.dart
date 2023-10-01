import 'package:bato_mechanic/screens/managers/route_manager.dart';
import 'package:bato_mechanic/utils/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base_view_model.dart';
import 'providers/session_provider.dart';

class AuthViewModel extends SessionProvider
    with BaseViewModel, ViewModelInputs, ViewModelOutputs {
  init(BuildContext context) {
    initViewModels(context);
  }

  destroy() {
    _phoneController.dispose();
    _passwordController.dispose();
  }

  @override
  login(BuildContext context) async {
    String phone = _phoneController.text;
    String password = _passwordController.text;

    systemProvider.showLoadingWithMessageOptional(context,
        message: 'Signing In');

    if (await super.createSession(phone, password)) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('accessToken', super.session!.accessToken);
      preferences.setString('refreshToken', super.session!.refreshToken);
      systemProvider.closeLoading(context);
      ToastHelper.showNotification(context, "You have been logged in");
      Navigator.of(context)
          .pushReplacementNamed(RoutesManager.vehicleCategoriesScreen);
    } else {
      print('he');
    }
  }
}

mixin ViewModelInputs {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  get phoneController => _phoneController;
  get passwordController => _passwordController;
}

mixin ViewModelOutputs on ViewModelInputs {
  login(BuildContext context) async {}
}
