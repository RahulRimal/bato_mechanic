import 'dart:async';
import 'dart:convert';

import 'package:bato_mechanic/data/map_api.dart';
import 'package:bato_mechanic/view_models/map_search_widget_view_model.dart';
import 'package:bato_mechanic/view_models/providers/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

import '../utils/flutter_map_utils/control_buttons/control_buttons.dart';

class MapSearchWidget extends StatefulWidget {
  const MapSearchWidget({super.key});

  @override
  State<MapSearchWidget> createState() => _MapSearchWidgetState();
}

class _MapSearchWidgetState extends State<MapSearchWidget>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late MapProvider mapProvider;

  @override
  void initState() {
    super.initState();
    // animationController = AnimationController(
    //     duration: const Duration(milliseconds: 500), vsync: this);
    mapProvider = Provider.of<MapProvider>(context, listen: false);
    mapProvider.bindMSWViewModel(context, this);
    // mapProvider.mswAnimationController = AnimationController(
    //     duration: const Duration(milliseconds: 500), vsync: this);

    // Register this object as an observer
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mapProvider.userPosition == null) {
        mapProvider.initializeLocation();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Added this line to save the reference of provider so it doesn't throw an exception on dispose
    mapProvider = Provider.of<MapProvider>(context, listen: false);
  }

  @override
  void dispose() {
    mapProvider.unBindMSWViewModel();
    // Unregister this object as an observer
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MapProvider mapProvider = context.watch<MapProvider>();

    return SafeArea(
      // child: mapProvider.loading
      //     ? const Center(child: CircularProgressIndicator())
      // :
      child: Stack(
        children: [
          _showMap(context),
          _buildSearchBar(),
        ],
      ),
    );
  }

  Widget _showMap(BuildContext context) {
    MapProvider mapProvider = context.watch<MapProvider>();
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      mapProvider.mswWidth = constraints.maxWidth;
      mapProvider.mswHeight = constraints.maxHeight;
      return FlutterMap(
        mapController: mapProvider.mswMapController,
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
          onTap: (tapPosition, latLng) async {
            mapProvider.mswMarkerPosition = latLng;

            String placeName = await mapProvider.getLocationName(
                latLng.latitude, latLng.longitude);
            // mapProvider.mswSearchController.text = placeName;
            mapProvider.mswSelectedPlaceName = placeName;
            mapProvider.mswAnimatedMapMove(
                latLng, mapProvider.mswMapController.zoom, mounted, this);
          },
          center: mapProvider.mswMarkerPosition,
          zoom: 15.0,
        ),
        nonRotatedChildren: [
          FlutterMapControlButtons(
            minZoom: 4,
            maxZoom: 19,
            mini: false,
            padding: 10,
            alignment: Alignment.bottomRight,
            mapController: mapProvider.mswMapController,
            // map: FlutterMapState.of(context),
          ),
          _buildSelectButton(),
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
        ],
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            tileProvider: NetworkTileProvider(),
          ),
          if (!mapProvider.loading)
            MarkerLayer(
              rotate: true,
              markers: [
                Marker(
                  width: 80,
                  height: 80,
                  point: mapProvider.mswMarkerPosition,
                  builder: (ctx) => const Icon(
                    Icons.location_on,
                    color: Colors.orange,
                    size: 40.0,
                  ),
                ),
              ],
            ),
          CurrentLocationLayer(),
          if (mapProvider.loading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      );
    });
  }

  Widget _buildSearchBar() {
    MapProvider mapProvider = context.watch<MapProvider>();
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
                controller: mapProvider.mapProvider.mswSearchController,
                focusNode: mapProvider.mswSearchFocusNode,
                decoration: InputDecoration(
                  hintText: 'Enter place name',
                  fillColor: Colors.white,
                  filled: true,
                  border: inputBorder,
                  focusedBorder: inputFocusBorder,
                  // hintStyle: TextStyle(color: widget.searchBarHintColor),
                  suffixIcon: IconButton(
                    onPressed: () {
                      mapProvider.mapProvider.mswSearchController.clear();

                      mapProvider.mswOptions = [];
                    },
                    icon: Icon(
                      Icons.clear,
                    ),
                  ),
                ),
                onChanged: (String value) {
                  if (mapProvider.mswDebounce?.isActive ?? false) {
                    mapProvider.mswDebounce?.cancel();
                  }

                  mapProvider.mswDebounce =
                      Timer(const Duration(milliseconds: 20), () async {
                    // var decodedResponse = await MapApi.getSearchLocations(
                    //     mapProvider.mapProvider.mswSearchController.text);
                    var response = await mapProvider.getSearchLocations(
                        mapProvider.mswSearchController.text);

                    mapProvider.mswOptions = response
                        .map((e) => OSMdata(
                            displayname: e['display_name'],
                            latitude: double.parse(e['lat']),
                            longitude: double.parse(e['lon'])))
                        .toList()
                        .cast<OSMdata>();
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

  Widget _buildSelectButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 15,
        ),
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Select this location'),
        ),
      ),
    );
  }

  Widget _buildListView() {
    MapProvider mapProvider = context.watch<MapProvider>();
    return ListView.builder(
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        // itemCount: mapProvider.mswOptions.length > 5
        //     ? 5
        //     : mapProvider.mswOptions.length,
        itemCount: mapProvider.mswOptions.length,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.white,
            child: ListTile(
              leading: Icon(Icons.location_on),
              title: Text(
                mapProvider.mswOptions[index].displayname,
              ),
              onTap: () {
                LatLng positionToMove = LatLng(
                    mapProvider.mswOptions[index].latitude,
                    mapProvider.mswOptions[index].longitude);

                mapProvider.mswMarkerPosition = positionToMove;
                mapProvider.mswMapController.center.latitude =
                    positionToMove.latitude;
                mapProvider.mswMapController.center.longitude =
                    positionToMove.longitude;

                // mapProvider.mswAnimatedMapMove(positionToMove, 18.0, mounted);
                mapProvider.mswAnimatedMapMove(positionToMove,
                    mapProvider.mswMapController.zoom, mounted, this);

                mapProvider.mswSearchFocusNode.unfocus();
                mapProvider.mswOptions.clear();
              },
            ),
          );
        });
  }
}
