import 'package:bato_mechanic/presentation/widgets/map_search/map_search_widget_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../data/map_api.dart';
import '../../app/utils/flutter_map_utils/control_buttons/control_buttons.dart';
import '../../app/utils/flutter_map_utils/scale_layer/scale_layer_plugin_option.dart';

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
  // ignore: unused_field, prefer_final_fields
  bool _showBigScreenMap = false;

  _getRouteCoordinates() async {
    var points = await MapApi.getRoute('85.33033043146135,27.703292452047425',
        '85.33825904130937, 27.707645262018172');

    setState(() {
      routeCoordinatePoints = points
          .map((point) => LatLng(point[1].toDouble(), point[0].toDouble()))
          .toList()
          .cast<LatLng>();
    });
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
                child: SizedBox(
                  height: 400,
                  // height: _showBigScreenMap
                  //     ? MediaQuery.of(context).size.height * 0.75
                  //     : 400,

                  child: _currentLocation != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: _showMechanicTrackMap(context),
                        )
                      : const Center(child: CircularProgressIndicator()),
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
                      style: const TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          // ignore: unnecessary_string_interpolations
                          text: '${widget.estimatedTimeOfArrival}',
                          style: const TextStyle(
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
              const ListTile(
                title: Text(
                  'Tire repair',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Tire repair and replacement',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
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
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'No parts included',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Rs. 3000',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Advance Cost Paid',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Rs. 2000',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Remaining Cost',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Rs. 1000',
                      style: TextStyle(
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

  FlutterMap _showMechanicTrackMap(BuildContext context) {
    LatLng cameraCenter = LatLng(27.703292452047425, 85.33033043146135);
    MapSearchWidgetViewModel mapSearchWidgetViewModel =
        context.watch<MapSearchWidgetViewModel>();
    return FlutterMap(
      mapController: mapSearchWidgetViewModel.mapController,
      options: MapOptions(
        // onTap: (tapPosition, latLng) {
        //   showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return AlertDialog(
        //         insetPadding: EdgeInsets.zero,
        //         contentPadding: EdgeInsets.zero,
        //         content: SizedBox(
        //             height: MediaQuery.of(context).size.height,
        //             width: MediaQuery.of(context).size.width,
        //             child: _showMechanicTrackMap(context)),
        //       );
        //     },
        //   );
        // },
        center: cameraCenter,
        zoom: 15.0,
        bounds: LatLngBounds(LatLng(27.703292452047425, 85.33033043146135),
            LatLng(27.707645262018172, 85.33825904130937)),
      ),
      nonRotatedChildren: [
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
        FlutterMapControlButtons(
          minZoom: 4,
          maxZoom: 19,
          mini: false,
          padding: 10,
          alignment: Alignment.bottomRight,
          mapController: mapSearchWidgetViewModel.mapController,
        ),
        CurrentLocationLayer(),
        // const RichAttributionWidget(
        //   popupInitialDisplayDuration: Duration(seconds: 5),
        //   animationConfig: ScaleRAWA(),
        //   showFlutterMapAttribution: false,
        //   attributions: [
        //     TextSourceAttribution(
        //       'Full Screen Mode',
        //       prependCopyright: false,
        //     ),
        //     TextSourceAttribution(
        //       'Tap on the map to show full screen map',
        //       prependCopyright: false,
        //     ),
        //   ],
        // ),
      ],
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          tileProvider: NetworkTileProvider(),
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 80,
              height: 80,
              point: LatLng(27.703292452047425, 85.33033043146135),
              builder: (ctx) => const Icon(
                Icons.location_on,
                color: Colors.orange,
                size: 40.0,
              ),
            ),
            Marker(
              width: 80,
              height: 80,
              point: LatLng(27.707645262018172, 85.33825904130937),
              builder: (ctx) => const Icon(
                Icons.location_on,
                color: Colors.purple,
                size: 40.0,
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
