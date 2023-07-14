import 'package:bato_mechanic/view_models/base_view_model.dart';
import 'package:bato_mechanic/view_models/map_search_widget_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';

import '../../data/map_api.dart';
import '../../models/system_models.dart';
import '../request_mechanic_screen_view_model.dart';

// mixin MapProvider on ChangeNotifier {
class MapProvider with ChangeNotifier, BaseViewModel, MapSearchWidgetViewModel {
  bool _loading = false;
  Position? _userPosition;
  // FlutterMapState? _mapState;
  MapError? _mapError;

  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Position? get userPosition => _userPosition;
  set userPosition(Position? value) {
    loading = true;
    _userPosition = value;
    loading = false;
  }

  // FlutterMapState? get mapState => _mapState;
  // set mapState(FlutterMapState? value) {
  //   _mapState = value;
  //   notifyListeners();
  // }

  MapError? get mapError => _mapError;
  set mapError(MapError? value) {
    _mapError = value;
  }

  initializeLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    Position position;
    loading = true;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await Geolocator.openLocationSettings();
      if (!serviceEnabled) {
        return;
      }
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    position = await Geolocator.getCurrentPosition();
    // setState(() {
    _userPosition = position;
    // });
    loading = false;
  }

  getLocationName(double lat, double lon) async {
    loading = true;
    var response = await MapApi.getLocationName(lat, lon);

    if (response is Success) {
      loading = false;
      return response.response;
    }

    if (response is Failure) {
      mapError = MapError(code: response.code, message: response.errorResponse);
    }
    loading = false;
    return null;
  }

  getSearchLocations(String searchText) async {
    loading = true;
    var response = await MapApi.getSearchLocations(searchText);

    if (response is Success) {
      loading = false;
      return response.response;
    }

    if (response is Failure) {
      mapError = MapError(code: response.code, message: response.errorResponse);
    }
    loading = false;
    return null;
  }
}

class MapError {
  int code;
  Object message;

  MapError({required this.code, required this.message});
}
