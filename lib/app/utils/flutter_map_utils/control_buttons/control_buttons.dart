import 'package:bato_mechanic/presentation/widgets/map_search/map_search_widget_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class FlutterMapControlButtons extends StatefulWidget {
  final double minZoom;
  final double maxZoom;
  final bool mini;
  final bool showZoomInButton;
  final bool showZoomOutButton;
  final bool showCurrentLocationButton;
  final double padding;
  final Alignment alignment;
  final Color? zoomInColor;
  final Color? zoomInColorIcon;
  final Color? zoomOutColor;
  final Color? zoomOutColorIcon;
  final Color? currentLocationColor;
  final Color? currentLocationColorIcon;
  final IconData zoomInIcon;
  final IconData zoomOutIcon;
  final IconData currentLocationIcon;
  final MapController mapController;
  // final FlutterMapState map;
  // final Position? currentLocation;

  const FlutterMapControlButtons({
    super.key,
    this.minZoom = 1,
    this.maxZoom = 18,
    this.mini = true,
    this.padding = 2.0,
    this.alignment = Alignment.topRight,
    this.zoomInColor,
    this.zoomInColorIcon,
    this.zoomInIcon = Icons.zoom_in,
    this.zoomOutColor,
    this.zoomOutColorIcon,
    this.zoomOutIcon = Icons.zoom_out,
    this.currentLocationColor,
    this.currentLocationColorIcon,
    this.currentLocationIcon = Icons.my_location,
    this.showZoomInButton = true,
    this.showZoomOutButton = true,
    this.showCurrentLocationButton = true,
    required this.mapController,
    // required this.map,

    // this.currentLocation,
  });

  @override
  State<FlutterMapControlButtons> createState() =>
      _FlutterMapControlButtonsState();
}

class _FlutterMapControlButtonsState extends State<FlutterMapControlButtons>
    with TickerProviderStateMixin {
  final FitBoundsOptions options =
      const FitBoundsOptions(padding: EdgeInsets.all(12));

  // late AnimationController _animationController;

  // void _animatedMapMove(LatLng destLocation, double destZoom) {
  //   // Create some tweens. These serve to split up the transition from one location to another.
  //   // In our case, we want to split the transition be<tween> our current map center and the destination.
  //   final latTween = Tween<double>(
  //       // begin: _mapController.center.latitude, end: destLocation.latitude);
  //       begin: widget.mapController.center.latitude,
  //       end: destLocation.latitude);
  //   final lngTween = Tween<double>(
  //       // begin: _mapController.center.longitude, end: destLocation.longitude);
  //       begin: widget.mapController.center.longitude,
  //       end: destLocation.longitude);
  //   // final zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);
  //   final zoomTween =
  //       Tween<double>(begin: widget.mapController.zoom, end: destZoom);
  //   // Create a animation controller that has a duration and a TickerProvider.
  //   if (mounted) {
  //     _animationController = AnimationController(
  //         vsync: this, duration: const Duration(milliseconds: 500));
  //   }
  //   // The animation determines what path the animation will take. You can try different Curves values, although I found
  //   // fastOutSlowIn to be my favorite.
  //   final Animation<double> animation = CurvedAnimation(
  //       parent: _animationController, curve: Curves.fastOutSlowIn);
  //   _animationController.addListener(() {
  //     // _mapController.move(
  //     widget.mapController.move(
  //         LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
  //         zoomTween.evaluate(animation));
  //   });
  //   if (mounted) {
  //     _animationController.forward();
  //   }
  // }

  @override
  void initState() {
    super.initState();

    // _animationController = AnimationController(
    //     duration: const Duration(milliseconds: 500), vsync: this);
  }

  @override
  void dispose() {
    // _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final map = FlutterMapState.of(context);
    // final map = widget.map;

    MapSearchWidgetViewModel mapSearchWidgetViewModel =
        context.watch<MapSearchWidgetViewModel>();

    return Align(
      alignment: widget.alignment,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (widget.showZoomInButton)
              Padding(
                padding: EdgeInsets.only(
                    left: widget.padding,
                    top: widget.padding,
                    right: widget.padding),
                child: FloatingActionButton(
                  heroTag: 'zoomInButton',
                  mini: widget.mini,
                  backgroundColor:
                      widget.zoomInColor ?? Theme.of(context).primaryColor,
                  onPressed: () {
                    final bounds = map.bounds;
                    final centerZoom = map.getBoundsCenterZoom(bounds, options);
                    var zoom = centerZoom.zoom + 1;
                    if (zoom > widget.maxZoom) {
                      zoom = widget.maxZoom;
                    }

                    // _animatedMapMove(centerZoom.center, zoom);
                    mapSearchWidgetViewModel.animatedMapMove(
                        centerZoom.center, zoom, mounted, this);
                  },
                  child: Icon(widget.zoomInIcon,
                      color: widget.zoomInColorIcon ??
                          IconTheme.of(context).color),
                ),
              ),
            if (widget.showZoomOutButton)
              Padding(
                padding: EdgeInsets.all(widget.padding),
                child: FloatingActionButton(
                  heroTag: 'zoomOutButton',
                  mini: widget.mini,
                  backgroundColor:
                      widget.zoomOutColor ?? Theme.of(context).primaryColor,
                  onPressed: () {
                    final bounds = map.bounds;
                    final centerZoom = map.getBoundsCenterZoom(bounds, options);
                    var zoom = centerZoom.zoom - 1;
                    if (zoom < widget.minZoom) {
                      zoom = widget.minZoom;
                    }

                    // _animatedMapMove(centerZoom.center, zoom);
                    mapSearchWidgetViewModel.animatedMapMove(
                        centerZoom.center, zoom, mounted, this);
                  },
                  child: Icon(widget.zoomOutIcon,
                      color: widget.zoomOutColorIcon ??
                          IconTheme.of(context).color),
                ),
              ),
            if (widget.showCurrentLocationButton)
              Padding(
                padding: EdgeInsets.all(widget.padding),
                child: FloatingActionButton(
                  heroTag: 'userLocationButton',
                  mini: widget.mini,
                  backgroundColor: widget.currentLocationColor ??
                      Theme.of(context).primaryColor,
                  onPressed: () async {
                    Position userPosition =
                        await Geolocator.getCurrentPosition();

                    // if(mapProvider.mswSelectedPlaceName == null){

                    // }

                    String? placeName =
                        await mapSearchWidgetViewModel.getLocationName(
                            userPosition.latitude, userPosition.longitude);
                    if (placeName != null) {
                      mapSearchWidgetViewModel.selectedPlaceName = placeName;
                    }

                    mapSearchWidgetViewModel.animatedMapMove(
                        LatLng(userPosition.latitude, userPosition.longitude),
                        15.0,
                        mounted,
                        this);
                  },
                  child: Icon(widget.currentLocationIcon,
                      color: widget.currentLocationColorIcon ??
                          IconTheme.of(context).color),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
