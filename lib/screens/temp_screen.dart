import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:math' show atan2;

class TempScreen extends StatefulWidget {
  @override
  _TempScreenState createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  MapController _mapController = MapController();
  double _rotationDegrees = 0.0; // Angle in degrees for rotation
  LatLng _previousPosition = LatLng(27.703292452047425, 85.33033043146135);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        center: LatLng(27.703292452047425, 85.33033043146135),
        zoom: 16.0,
        onPositionChanged: (MapPosition position, bool hasGesture) {
          // Calculate rotation based on map movement
          LatLng currentPosition = position.center as LatLng;
          double rotation =
              calculateRotation(_previousPosition, currentPosition);
          setState(() {
            _rotationDegrees = rotation;
            _previousPosition = currentPosition;
          });
        },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          tileProvider: NetworkTileProvider(),
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 50.0,
              height: 50.0,
              point: LatLng(27.703292452047425, 85.33033043146135),
              builder: (ctx) {
                return Transform.rotate(
                  angle: _rotationDegrees *
                      (3.1415927 / 180), // Convert degrees to radians
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.blue,
                    size: 50.0,
                  ),
                );
              },
            ),
          ],
        ),
      ],
      // layers: [
      //   TileLayerOptions(
      //     urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
      //     subdomains: ['a', 'b', 'c'],
      //   ),
      //   MarkerLayerOptions(
      //     markers: [
      //       Marker(
      //         width: 50.0,
      //         height: 50.0,
      //         point: LatLng(27.703292452047425, 85.33033043146135),
      //         builder: (ctx) {
      //           return Transform.rotate(
      //             angle: _rotationDegrees *
      //                 (3.1415927 / 180), // Convert degrees to radians
      //             child: Icon(
      //               Icons.arrow_forward,
      //               color: Colors.blue,
      //               size: 50.0,
      //             ),
      //           );
      //         },
      //       ),
      //     ],
      //   ),
      // ],
    );
  }

  double calculateRotation(LatLng previousPosition, LatLng currentPosition) {
    double latDiff = currentPosition.latitude - previousPosition.latitude;
    double lngDiff = currentPosition.longitude - previousPosition.longitude;
    double rotation = -atan2(lngDiff, latDiff) * 180 / pi;
    return rotation;
  }
}
