import 'dart:async';

import 'package:bato_mechanic/view_models/base_view_model.dart';
import 'package:bato_mechanic/view_models/providers/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

// class MapSearchWidgetViewModel with ChangeNotifier, BaseViewModel {
mixin MapSearchWidgetViewModel on ChangeNotifier, BaseViewModel {
  LatLng _markerPosition = LatLng(27.703292452047425, 85.33033043146135);
  MapController _mapController = MapController();
  late AnimationController _animationController;
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();
  List<OSMdata> _options = <OSMdata>[];
  Timer? _debounce;

  late double _width;
  late double _height;

  // StreamSubscription<MapEvent>? mapEventSubscription;

  LatLng get mswMarkerPosition => _markerPosition;
  set mswMarkerPosition(LatLng value) {
    _markerPosition = value;
    notifyListeners();
  }

  MapController get mswMapController => _mapController;
  set mswMapController(MapController value) {
    _mapController = value;
  }

  AnimationController get mswAnimationController => _animationController;
  set mswAnimationController(AnimationController value) {
    _animationController = value;
  }

  TextEditingController get mswSearchController => _searchController;
  set mswSearchController(TextEditingController value) {
    _searchController = value;
  }

  FocusNode get mswSearchFocusNode => _searchFocusNode;
  set mswSearchFocusNode(FocusNode value) {
    _searchFocusNode = value;
  }

  List<OSMdata> get mswOptions => _options;
  set mswOptions(List<OSMdata> value) {
    _options = value;
    notifyListeners();
  }

  Timer? get mswDebounce => _debounce;
  set mswDebounce(Timer? value) {
    _debounce = value;
  }

  double get mswWidth => _width;
  set mswWidth(double value) {
    _width = value;
  }

  double get mswHeight => _height;
  set mswHeight(double value) {
    _height = value;
  }

  bindMSWViewModel(BuildContext context) {
    bindBaseViewModal(context);

    mswMapController = MapController();

    /// The above code is listening to the mapEventStream and when the mapEventMoveEnd event is
    /// triggered, it moves the pointer to that position

    mswMapController.mapEventStream.listen((event) async {
      if (event is MapEventMove) {
        mswMarkerPosition = mswMapController
            .pointToLatLng(CustomPoint(_width / 2, _height / 2)) as LatLng;
        // notifyListeners();
      }
      if (event is MapEventMoveEnd) {
        String? placeName = await mapProvider.getLocationName(
            event.center.latitude, event.center.longitude);
        if (placeName != null) {
          _searchController.text = placeName;
        } else {
          print('here');
        }
      }
    });
  }

  unBindMSWViewModel() {
    _mapController.dispose();
    _animationController.dispose();
    unBindMSWViewModel();
  }

  void mswAnimatedMapMove(LatLng destLocation, double destZoom, bool mounted) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final latTween = Tween<double>(
        begin: mswMapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: mswMapController.center.longitude, end: destLocation.longitude);
    final zoomTween =
        Tween<double>(begin: mswMapController.zoom, end: destZoom);
    // Create a animation controller that has a duration and a TickerProvider.
    // if (mounted) {
    //   animationController = AnimationController(
    //       vsync: this, duration: const Duration(milliseconds: 500));
    // }
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
