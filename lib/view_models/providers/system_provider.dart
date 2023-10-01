import 'package:flutter/material.dart';

import '../../utils/toast_helper.dart';

class SystemProvider with ChangeNotifier {
  String? _loadingMessage;
  bool _loadingEnabled = false;
  String? get loadingMessage => _loadingMessage;
  set loadingMessage(String? value) {
    _loadingMessage = value;
    notifyListeners();
  }

  showLoadingWithMessageOptional(BuildContext context, {message}) {
    // If loading is enabled then do not instantiate new loading but just change the loading message
    loadingMessage = message;
    if (!_loadingEnabled) {
      ToastHelper.showLoading(context);
      _loadingEnabled = true;
    }
  }

  closeLoading(BuildContext context) {
    if (_loadingEnabled) {
      loadingMessage = null;
      Navigator.of(context).pop();
      _loadingEnabled = false;
    }
  }
}
