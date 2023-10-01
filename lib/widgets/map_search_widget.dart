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
  late MapSearchWidgetViewModel _mapSearchWidgetViewModel;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mapSearchWidgetViewModel =
          Provider.of<MapSearchWidgetViewModel>(context, listen: false);
      _mapSearchWidgetViewModel.init(context, this);
      // if (_mapSearchWidgetViewModel.userPosition == null) {
      //   _mapSearchWidgetViewModel.initializeLocation();
      // }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Added this line to save the reference of provider so it doesn't throw an exception on dispose
    _mapSearchWidgetViewModel =
        Provider.of<MapSearchWidgetViewModel>(context, listen: false);
  }

  @override
  void dispose() {
    _mapSearchWidgetViewModel.destroy();
    // Unregister this object as an observer
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MapSearchWidgetViewModel mapSearchWidgetViewModel =
        context.watch<MapSearchWidgetViewModel>();

    return SafeArea(
      child: Stack(
        children: [
          _showMap(context, mapSearchWidgetViewModel),
          _buildSearchBar(mapSearchWidgetViewModel),
        ],
      ),
    );
  }

  Widget _showMap(
      BuildContext context, MapSearchWidgetViewModel mapSearchWidgetViewModel) {
    // MapSearchWidgetViewModel mapSearchWidgetViewModel =
    //     context.watch<MapSearchWidgetViewModel>();
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      mapSearchWidgetViewModel.width = constraints.maxWidth;
      mapSearchWidgetViewModel.height = constraints.maxHeight;
      return FlutterMap(
        mapController: mapSearchWidgetViewModel.mapController,
        options: MapOptions(
          onTap: (tapPosition, latLng) async {
            mapSearchWidgetViewModel.markerPosition = latLng;

            String placeName = await mapSearchWidgetViewModel.getLocationName(
                latLng.latitude, latLng.longitude);
            mapSearchWidgetViewModel.selectedPlaceName = placeName;
            mapSearchWidgetViewModel.animatedMapMove(latLng,
                mapSearchWidgetViewModel.mapController.zoom, mounted, this);
          },
          center: mapSearchWidgetViewModel.markerPosition,
          zoom: 15.0,
        ),
        nonRotatedChildren: [
          FlutterMapControlButtons(
            minZoom: 4,
            maxZoom: 19,
            mini: false,
            padding: 10,
            alignment: Alignment.bottomRight,
            mapController: mapSearchWidgetViewModel.mapController,
            // map: FlutterMapState.of(context),
          ),
          _buildSelectButton(),
          // const RichAttributionWidget(
          //   popupInitialDisplayDuration: const Duration(seconds: 5),
          //   animationConfig: const ScaleRAWA(),
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
          if (!mapSearchWidgetViewModel.loading)
            MarkerLayer(
              rotate: true,
              markers: [
                Marker(
                  width: 80,
                  height: 80,
                  point: mapSearchWidgetViewModel.markerPosition,
                  builder: (ctx) => const Icon(
                    Icons.location_on,
                    color: Colors.orange,
                    size: 40.0,
                  ),
                ),
              ],
            ),
          CurrentLocationLayer(),
          if (mapSearchWidgetViewModel.loading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      );
    });
  }

  Widget _buildSearchBar(MapSearchWidgetViewModel mapSearchWidgetViewModel) {
    // MapSearchWidgetViewModel mapSearchWidgetViewModel =
    //     context.watch<MapSearchWidgetViewModel>();
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
                controller: mapSearchWidgetViewModel.searchController,
                focusNode: mapSearchWidgetViewModel.searchFocusNode,
                decoration: InputDecoration(
                  hintText: 'Enter place name',
                  fillColor: Colors.white,
                  filled: true,
                  border: inputBorder,
                  focusedBorder: inputFocusBorder,
                  // hintStyle: TextStyle(color: widget.searchBarHintColor),
                  suffixIcon: IconButton(
                    onPressed: () {
                      mapSearchWidgetViewModel.searchController.clear();

                      mapSearchWidgetViewModel.options = [];
                    },
                    icon: Icon(
                      Icons.clear,
                    ),
                  ),
                ),
                onChanged: (String value) {
                  if (mapSearchWidgetViewModel.debounce?.isActive ?? false) {
                    mapSearchWidgetViewModel.debounce?.cancel();
                  }

                  mapSearchWidgetViewModel.debounce =
                      Timer(const Duration(milliseconds: 20), () async {
                    // var decodedResponse = await MapApi.getSearchLocations(
                    //     mapProvider.mapProvider.mswSearchController.text);
                    var response =
                        await mapSearchWidgetViewModel.getSearchLocations(
                            mapSearchWidgetViewModel.searchController.text);

                    mapSearchWidgetViewModel.options = response
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
    MapSearchWidgetViewModel mapSearchWidgetViewModel =
        context.watch<MapSearchWidgetViewModel>();
    return ListView.builder(
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        // itemCount: mapProvider.mswOptions.length > 5
        //     ? 5
        //     : mapProvider.mswOptions.length,
        itemCount: mapSearchWidgetViewModel.options.length,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.white,
            child: ListTile(
              leading: Icon(Icons.location_on),
              title: Text(
                mapSearchWidgetViewModel.options[index].displayname,
              ),
              onTap: () {
                LatLng positionToMove = LatLng(
                    mapSearchWidgetViewModel.options[index].latitude,
                    mapSearchWidgetViewModel.options[index].longitude);

                mapSearchWidgetViewModel.markerPosition = positionToMove;
                mapSearchWidgetViewModel.mapController.center.latitude =
                    positionToMove.latitude;
                mapSearchWidgetViewModel.mapController.center.longitude =
                    positionToMove.longitude;

                // mapProvider.mswAnimatedMapMove(positionToMove, 18.0, mounted);
                mapSearchWidgetViewModel.animatedMapMove(positionToMove,
                    mapSearchWidgetViewModel.mapController.zoom, mounted, this);

                mapSearchWidgetViewModel.searchFocusNode.unfocus();
                mapSearchWidgetViewModel.options.clear();
              },
            ),
          );
        });
  }
}
