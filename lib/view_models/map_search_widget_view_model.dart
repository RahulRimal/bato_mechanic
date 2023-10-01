import 'dart:async';

import 'package:bato_mechanic/view_models/providers/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

import 'base_view_model.dart';

class MapSearchWidgetViewModel extends MapProvider
    with BaseViewModel, ViewModelInputs, ViewModelOutputs {
  init(BuildContext context, TickerProvider vsync) {
    initViewModels(context);
    _mapController = MapController();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: vsync);

    if (super.userPosition == null) {
      super.initializeLocation();
    }

    /// The below code is listening to the mapEventStream and when the mapEventMoveEnd event is
    /// triggered, it moves the pointer to that position

    _mapController.mapEventStream.listen((event) async {
      if (event is MapEventMove) {
        _markerPosition = _mapController
            .pointToLatLng(CustomPoint(_width / 2, _height / 2)) as LatLng;
        notifyListeners();
      }
      if (event is MapEventMoveEnd) {
        String? placeName = await super
            .getLocationName(event.center.latitude, event.center.longitude);
        if (placeName != null) {
          _searchController.text = placeName;
          _selectedPlaceName = placeName;
          notifyListeners();
        } else {
          print('here');
        }
      }
    });
  }

  destroy() {
    // _mapController.dispose();
    _animationController.dispose();
  }

  void animatedMapMove(LatLng destLocation, double destZoom, bool mounted,
      TickerProvider vsync) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final latTween = Tween<double>(
        begin: _mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: _mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);
    // Create a animation controller that has a duration and a TickerProvider.
    if (mounted) {
      _animationController = AnimationController(
          vsync: vsync, duration: const Duration(milliseconds: 500));
    }
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    final Animation<double> animation = CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn);

    _animationController.addListener(() {
      _mapController.move(
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
          zoomTween.evaluate(animation));
    });

    if (mounted) {
      _animationController.forward();
    }
  }
}

mixin ViewModelInputs {
  LatLng _markerPosition = LatLng(27.703292452047425, 85.33033043146135);
  String? _selectedPlaceName;
  MapController _mapController = MapController();
  late AnimationController _animationController;
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();
  List<OSMdata> _options = <OSMdata>[];
  Timer? _debounce;

  // late double _width;
  // late double _height;
  double _width = 10;
  double _height = 10;

  LatLng get markerPosition => _markerPosition;
  MapController get mapController => _mapController;
  AnimationController get animationController => _animationController;

  TextEditingController get searchController => _searchController;
  FocusNode get searchFocusNode => _searchFocusNode;
  List<OSMdata> get options => _options;
  Timer? get debounce => _debounce;
  double get width => _width;
  double get height => _height;
  String? get selectedPlaceName => _selectedPlaceName;
}
mixin ViewModelOutputs on ChangeNotifier, ViewModelInputs {
  set markerPosition(LatLng value) {
    _markerPosition = value;
    notifyListeners();
  }

  set mapController(MapController value) {
    _mapController = value;
  }

  set animationController(AnimationController value) {
    _animationController = value;
  }

  set searchController(TextEditingController value) {
    _searchController = value;
  }

  set searchFocusNode(FocusNode value) {
    _searchFocusNode = value;
  }

  set options(List<OSMdata> value) {
    _options = value;
    notifyListeners();
  }

  set debounce(Timer? value) {
    _debounce = value;
  }

  set width(double value) {
    _width = value;
  }

  set height(double value) {
    _height = value;
  }

  set selectedPlaceName(String? value) {
    _selectedPlaceName = value;
    if (value != null) _searchController.text = value;
    notifyListeners();
  }
}

class OSMdata {
  final String displayname;
  final double latitude;
  final double longitude;
  OSMdata(
      {required this.displayname,
      required this.latitude,
      required this.longitude});
  @override
  String toString() {
    return '$displayname, $latitude, $longitude';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is OSMdata && other.displayname == displayname;
  }

  @override
  int get hashCode => Object.hash(displayname, latitude, longitude);
}

// class LatLong {
//   final double latitude;
//   final double longitude;
//   LatLong(this.latitude, this.longitude);
// }

class PickedData {
  // final LatLong latLong;
  final LatLng latLng;
  final String address;
  final Map<String, dynamic> addressData;

  PickedData(this.latLng, this.address, this.addressData);
}
