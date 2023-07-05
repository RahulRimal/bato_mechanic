import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

import '../data/system_api.dart';
import '../utils/flutter_map_utils/scale_layer_plugin_option.dart';

class TrackMechanicScreen extends StatefulWidget {
  final String mechanicName;
  final String estimatedTimeOfArrival;
  final String mechanicLocation;

  const TrackMechanicScreen({
    Key? key,
    required this.mechanicName,
    required this.estimatedTimeOfArrival,
    required this.mechanicLocation,
  }) : super(key: key);

  @override
  State<TrackMechanicScreen> createState() => _TrackMechanicScreenState();
}

class _TrackMechanicScreenState extends State<TrackMechanicScreen> {
  Position? _currentLocation;
  List<LatLng> routeCoordinatePoints = [];

  _getRouteCoordinates() async {
    var points = await SystemApi.getRoute(
        '85.33033043146135,27.703292452047425',
        '85.33825904130937, 27.707645262018172');

    routeCoordinatePoints = points
        .map((point) => LatLng(point[1].toDouble(), point[0].toDouble()))
        .toList()
        .cast<LatLng>();
  }

  Future<void> _initializeLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    Position position;

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
    setState(() {
      _currentLocation = position;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeLocation();
    _getRouteCoordinates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Mechanic'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mechanic: ${widget.mechanicName}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Mechanic Location: ${widget.mechanicLocation}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullScreenMapScreen(
                        mechanicLocation: widget.mechanicLocation,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: _currentLocation != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: FlutterMap(
                            options: MapOptions(
                              center: const LatLng(
                                  27.703292452047425, 85.33033043146135),
                              zoom: 15.0,
                              bounds: LatLngBounds(
                                  LatLng(27.703292452047425, 85.33033043146135),
                                  LatLng(
                                      27.707645262018172, 85.33825904130937)),
                            ),
                            nonRotatedChildren: [
                              // RichAttributionWidget(
                              //   popupInitialDisplayDuration:
                              //       const Duration(seconds: 5),
                              //   animationConfig: const ScaleRAWA(),
                              //   attributions: [
                              //     TextSourceAttribution(
                              //       'OpenStreetMap contributors',
                              //     ),
                              //     const TextSourceAttribution(
                              //       'This attribution is the same throughout this app, except where otherwise specified',
                              //       prependCopyright: false,
                              //     ),
                              //   ],
                              // ),

                              ScaleLayerWidget(
                                options: ScaleLayerPluginOption(
                                  lineColor: Colors.black,
                                  lineWidth: 2,
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                ),
                              ),
                            ],
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName:
                                    'dev.fleaflet.flutter_map.example',
                                tileProvider: NetworkTileProvider(),
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    width: 80,
                                    height: 80,
                                    point: const LatLng(
                                        27.703292452047425, 85.33033043146135),
                                    builder: (ctx) => Container(
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.orange,
                                        size: 40.0,
                                      ),
                                    ),
                                  ),
                                  Marker(
                                    width: 80,
                                    height: 80,
                                    point: const LatLng(
                                        27.707645262018172, 85.33825904130937),
                                    builder: (ctx) => Container(
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.purple,
                                        size: 40.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              PolylineLayer(
                                polylines: [
                                  Polyline(
                                    points: routeCoordinatePoints,
                                    strokeWidth: 4,
                                    color: Colors.purple,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : Center(child: const CircularProgressIndicator()),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    // height: 50,
                    width: 75,
                    decoration: BoxDecoration(
                      color: Colors.amberAccent[200],
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: Image.asset(
                      'assets/images/parts/wheel.png',
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Estimated Arrival Time: ',
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${widget.estimatedTimeOfArrival}',
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              ListTile(
                title: Text(
                  'Tire repair',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text(
                  'Tire repair and replacement',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Cost',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'No parts included',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Rs. 3000',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Advance Cost Paid',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Rs. 2000',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Remaining Cost',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Rs. 1000',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FullScreenMapScreen extends StatelessWidget {
  final String mechanicLocation;

  const FullScreenMapScreen({Key? key, required this.mechanicLocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Screen Map'),
      ),
      body: const Center(
        child: Text(
          'Full screen map goes here',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}