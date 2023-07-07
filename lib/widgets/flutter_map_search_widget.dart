import 'dart:async';
import 'dart:convert';

import 'package:bato_mechanic/data/map_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

import '../utils/flutter_map_utils/control_buttons/control_buttons.dart';

class FlutterMapSearchWidget extends StatefulWidget {
  const FlutterMapSearchWidget({super.key});

  @override
  State<FlutterMapSearchWidget> createState() => _FlutterMapSearchWidgetState();
}

class _FlutterMapSearchWidgetState extends State<FlutterMapSearchWidget>
    with TickerProviderStateMixin {
  // LatLng cameraCenter = LatLng(27.703292452047425, 85.33033043146135);
  LatLng markerPosition = LatLng(27.703292452047425, 85.33033043146135);
  MapController mapController = new MapController();
  late AnimationController animationController;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<OSMdata> _options = <OSMdata>[];
  Timer? _debounce;

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);
    // Create a animation controller that has a duration and a TickerProvider.
    if (mounted) {
      animationController = AnimationController(
          vsync: this, duration: const Duration(milliseconds: 500));
    }
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    final Animation<double> animation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);

    animationController.addListener(() {
      mapController.move(
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
          zoomTween.evaluate(animation));
    });

    if (mounted) {
      animationController.forward();
    }
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
      // _currentLocation = position;
      markerPosition = LatLng(position.latitude, position.longitude);
      
    });
  }

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    _initializeLocation();

    /// The above code is listening to the mapEventStream and when the mapEventMoveEnd event is
    /// triggered, it moves the pointer to that position
    mapController.mapEventStream.listen((event) async {

      
      if(event is MapEventMove )
      {
        setState(() {
        markerPosition = mapController.pointToLatLng(CustomPoint(MediaQuery.of(context).size.width / 2, MediaQuery.of(context).size.height / 2)) as LatLng;
        });
      }
      if (event is MapEventMoveEnd) {
        
        String placeName =
                        
                        await MapApi.getLocationName(event.center.latitude, event.center.longitude );

                        _searchController.text = placeName;

                    
                    
        //   LatLng positionToMove = LatLng(event.center.latitude, event.center.longitude);
        // setState(() {
        //           markerPosition = positionToMove;
        //           mapController.center.latitude = positionToMove.latitude;
        //           mapController.center.longitude = positionToMove.longitude;
        //         });
        // _animatedMapMove(positionToMove, 15.0);
        
      }
  });
  }

  @override
  void dispose() {
    mapController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          _showMap(context),
          _buildSearchBar(),
        ],
      ),
    );
  }

  Widget _showMap(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
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
        //             child: _showMap(context)),
        //       );
        //     },
        //   );
        // },
        center: markerPosition,
        zoom: 15.0,
        
      ),
      nonRotatedChildren: [
        const RichAttributionWidget(
          popupInitialDisplayDuration: const Duration(seconds: 5),
          animationConfig: const ScaleRAWA(),
          showFlutterMapAttribution: false,
          attributions: [
            TextSourceAttribution(
              'Full Screen Mode',
              prependCopyright: false,
            ),
            const TextSourceAttribution(
              'Tap on the map to show full screen map',
              prependCopyright: false,
            ),
          ],
        ),
        CurrentLocationLayer(),
        FlutterMapControlButtons(
          minZoom: 4,
          maxZoom: 19,
          mini: false,
          padding: 10,
          alignment: Alignment.bottomRight,
          mapController: mapController,
        ),
        
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
              point: markerPosition,
              builder: (ctx) => const Icon(
                Icons.location_on,
                color: Colors.orange,
                size: 40.0,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    OutlineInputBorder inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
    );
    OutlineInputBorder inputFocusBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 3.0),
    );

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            TextFormField(
                controller: _searchController,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: 'Enter place name',
                  fillColor: Colors.white,
                  filled: true,
                  border: inputBorder,
                  focusedBorder: inputFocusBorder,
                  // hintStyle: TextStyle(color: widget.searchBarHintColor),
                  suffixIcon: IconButton(
                    onPressed: () {
                     _searchController.clear();
                     setState(() {
                       
                     _options = [];
                     });
                    },
                    icon: Icon(
                      Icons.clear,
                      // color: widget.searchBarTextColor,
                    ),
                  ),
                ),
                onChanged: (String value) {
                  if (_debounce?.isActive ?? false) {
                    _debounce?.cancel();
                  }
                  setState(() {});
                  _debounce = Timer(const Duration(milliseconds: 20), () async {
                    var decodedResponse =
                        await MapApi.getSearchLocations(_searchController.text);

                    _options = decodedResponse
                        .map((e) => OSMdata(
                            displayname: e['display_name'],
                            latitude: double.parse(e['lat']),
                            longitude: double.parse(e['lon'])))
                        .toList()
                        .cast<OSMdata>();
                    setState(() {});
                  });
                }),
                _buildListView(),
            // StatefulBuilder(builder: ((context, setState) {
            //   return _buildListView();
            // })),
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _options.length > 5 ? 5 : _options.length,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.white,
            child: ListTile(
              leading: Icon(Icons.location_on),
              title: Text(
                _options[index].displayname,
              ),
              onTap: () {
                LatLng positionToMove =
                    LatLng(_options[index].latitude, _options[index].longitude);
                setState(() {
                  markerPosition = positionToMove;
                  mapController.center.latitude = positionToMove.latitude;
                  mapController.center.longitude = positionToMove.longitude;
                });
                _animatedMapMove(positionToMove, 18.0);
                

                _focusNode.unfocus();
                _options.clear();
                // setState(() {});
              },
            ),
          );
        });
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

class LatLong {
  final double latitude;
  final double longitude;
  LatLong(this.latitude, this.longitude);
}

class PickedData {
  final LatLong latLong;
  final String address;
  final Map<String, dynamic> addressData;

  PickedData(this.latLong, this.address, this.addressData);
}
