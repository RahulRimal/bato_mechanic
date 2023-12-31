import 'dart:io';
import 'package:bato_mechanic/presentation/request_mechanic/request_mechanic_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:video_player/video_player.dart';

import '../widgets/map_search/map_search_widget.dart';

class RequestMechanicScreen extends StatefulWidget {
  const RequestMechanicScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RequestMechanicScreenState createState() => _RequestMechanicScreenState();
}

class _RequestMechanicScreenState extends State<RequestMechanicScreen>
    with WidgetsBindingObserver {
  late RequestMechanicScreenViewModel _requestMechanicViewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _requestMechanicViewModel =
          Provider.of<RequestMechanicScreenViewModel>(context, listen: false);
      _requestMechanicViewModel.init(context);
    });
  }

  @override
  void dispose() {
    _requestMechanicViewModel.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RequestMechanicScreenViewModel requestMechanicViewModel =
        context.watch<RequestMechanicScreenViewModel>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Request Mechanic'),
        ),
        body: _buildUI(requestMechanicViewModel));
  }

  _buildUI(RequestMechanicScreenViewModel requestMechanicViewModel) {
    if (requestMechanicViewModel.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (requestMechanicViewModel.mechanicError != null) {
      return Center(
        child: Text(requestMechanicViewModel.mechanicError!.message.toString()),
      );
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Provide your location:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 400,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: const MapSearchWidget(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Describe the issue:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: requestMechanicViewModel.issueDescriptionController,
              focusNode: requestMechanicViewModel.issueDescriptionFocusNode,
              decoration: const InputDecoration(
                hintText: 'Describe the issue',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            const Text(
              'Attach photos:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(
                  // onPressed: _pickImage,
                  onPressed: requestMechanicViewModel.pickImages,
                  child: const Text('Add Photos'),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // children: _selectedImages.map((File image) {
                      children: requestMechanicViewModel.selectedImages
                          .map((File image) {
                        return Container(
                          margin: const EdgeInsets.only(right: 8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.file(
                                    image,
                                    width: 100,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -10,
                                right: -10,
                                child: IconButton(
                                  onPressed: () {
                                    requestMechanicViewModel
                                        .removeSelectedImage(image);
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.amberAccent[200],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Attach a video:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: requestMechanicViewModel.pickVideo,
              child: requestMechanicViewModel.videoController != null
                  ? const Text('Change Video')
                  : const Text('Add Video'),
            ),
            if (requestMechanicViewModel.videoController != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: AspectRatio(
                  aspectRatio: requestMechanicViewModel
                      .videoController!.value.aspectRatio,
                  child: VideoPlayer(requestMechanicViewModel.videoController!),
                ),
              ),
            const SizedBox(height: 16),
            const Text(
              'Select prefered mechanic',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (requestMechanicViewModel.loading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else
              SizedBox(
                height: 130,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    // itemCount: 5,
                    itemCount:
                        requestMechanicViewModel.recommendedMechanics.length,
                    itemBuilder: (context, index) => GestureDetector(
                          onTap: () =>
                              requestMechanicViewModel.preferedMechanic =
                                  requestMechanicViewModel
                                      .recommendedMechanics[index],
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.amberAccent[200],
                              border:
                                  requestMechanicViewModel.preferedMechanic ==
                                          requestMechanicViewModel
                                              .recommendedMechanics[index]
                                      ? Border.all(
                                          color: Colors.blue,
                                          width: 2,
                                        )
                                      : null,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: SizedBox(
                              width: 130,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    // child: Image.asset(
                                    //   'assets/images/no-profile.png',
                                    // ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 4,
                                      ),
                                      child: Image.network(
                                        requestMechanicViewModel
                                            .recommendedMechanics[index].image,
                                      ),
                                    ),
                                  ),
                                  // const SizedBox(height: 8),
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          // '4.5',
                                          requestMechanicViewModel
                                              .recommendedMechanics[index]
                                              .averageRating
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        const Icon(
                                          Icons.star,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                requestMechanicViewModel.requestForVehicleRepair(context);
              },
              child: const Text('Request for a mechanic'),
            ),
          ],
        ),
      ),
    );
  }
}



// -------------------------------------- Map integration using google maps starts here -------------------------------------------

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class RequestMechanicScreen extends StatefulWidget {
//   @override
//   _RequestMechanicScreenState createState() => _RequestMechanicScreenState();
// }

// class _RequestMechanicScreenState extends State<RequestMechanicScreen> {
//   final Completer<GoogleMapController> _controller = Completer();

//   static const LatLng sourceLocation = LatLng(37.3300926, -122.03272188);
//   static const LatLng destination = LatLng(37.33429383, -122.06600055);

//   List<LatLng> polylineCoordinates = [];

//   void getPolyPoints() async {
//     PolylinePoints polylinePoints = PolylinePoints();
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       'AIzaSyCtV10-IveVc0T2kd1WKL2zFtKUkEKbsN8',
//       PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
//       PointLatLng(destination.latitude, destination.longitude),
//     );

//     if (result.points.isNotEmpty) {
//       result.points.forEach(
//         (PointLatLng point) =>
//             polylineCoordinates.add(LatLng(point.latitude, point.longitude)),
//       );
//       print(polylineCoordinates);
//       setState(() {});
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getPolyPoints();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Appbar'),
//       ),
//       body: GoogleMap(
//         polylines: {
//           Polyline(
//             polylineId: PolylineId("route"),
//             points: polylineCoordinates,
//             color: Colors.black,
//             width: 6,
//           ),
//         },
//         initialCameraPosition: CameraPosition(
//           target: sourceLocation,
//           zoom: 13.5,
//         ),
//         markers: {
//           Marker(
//             markerId: MarkerId("source"),
//             position: sourceLocation,
//           ),
//           Marker(
//             markerId: MarkerId("destination"),
//             position: destination,
//           ),
//         },
//       ),
//     );
//   }
// }

// -------------------------------------- Map integration using google maps ends here -------------------------------------------

// import 'package:flutter/material.dart';

// class RequestMechanicScreen extends StatefulWidget {
//   const RequestMechanicScreen({super.key});

//   @override
//   State<RequestMechanicScreen> createState() => _RequestMechanicScreenState();
// }

// class _RequestMechanicScreenState extends State<RequestMechanicScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Appbar'),
//       ),
//     );
//   }
// }

// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_map/flutter_map.dart';

// class RequestMechanicScreen extends StatefulWidget {
//   static const String route = '/';

//   const RequestMechanicScreen({Key? key}) : super(key: key);

//   @override
//   State<RequestMechanicScreen> createState() => _RequestMechanicScreenState();
// }

// class _RequestMechanicScreenState extends State<RequestMechanicScreen> {
//   // @override
//   // void initState() {
//   //   super.initState();

//   //   const seenIntroBoxKey = 'seenIntroBox(a)';
//   //   if (kIsWeb && Uri.base.host.trim() == 'demo.fleaflet.dev') {
//   //     SchedulerBinding.instance.addPostFrameCallback(
//   //       (_) async {
//   //         final prefs = await SharedPreferences.getInstance();
//   //         if (prefs.getBool(seenIntroBoxKey) ?? false) return;

//   //         if (!mounted) return;

//   //         final width = MediaQuery.of(context).size.width;
//   //         await showDialog<void>(
//   //           context: context,
//   //           builder: (context) => AlertDialog(
//   //             icon: UnconstrainedBox(
//   //               child: SizedBox.square(
//   //                 dimension: 64,
//   //                 child:
//   //                     Image.asset('assets/ProjectIcon.png', fit: BoxFit.fill),
//   //               ),
//   //             ),
//   //             title: const Text('flutter_map Live Web Demo'),
//   //             content: ConstrainedBox(
//   //               constraints: BoxConstraints(
//   //                 maxWidth: width < 750
//   //                     ? double.infinity
//   //                     : (width / (width < 1100 ? 1.5 : 2.5)),
//   //               ),
//   //               child: Column(
//   //                 mainAxisSize: MainAxisSize.min,
//   //                 children: [
//   //                   const Text(
//   //                     "This is built automatically off of the latest commits to 'master', so may not reflect the latest release available on pub.dev.\nThis is hosted on Firebase Hosting, meaning there's limited bandwidth to share between all users, so please keep loads to a minimum.",
//   //                     textAlign: TextAlign.center,
//   //                   ),
//   //                   Padding(
//   //                     padding:
//   //                         const EdgeInsets.only(right: 8, top: 16, bottom: 4),
//   //                     child: Align(
//   //                       alignment: Alignment.centerRight,
//   //                       child: Text(
//   //                         "This won't be shown again",
//   //                         style: TextStyle(
//   //                           color: Theme.of(context)
//   //                               .colorScheme
//   //                               .inverseSurface
//   //                               .withOpacity(0.5),
//   //                         ),
//   //                         textAlign: TextAlign.right,
//   //                       ),
//   //                     ),
//   //                   ),
//   //                 ],
//   //               ),
//   //             ),
//   //             actions: [
//   //               TextButton.icon(
//   //                 onPressed: () => Navigator.of(context).pop(),
//   //                 label: const Text('OK'),
//   //                 icon: const Icon(Icons.done),
//   //               ),
//   //             ],
//   //             contentPadding: const EdgeInsets.only(
//   //               left: 24,
//   //               top: 16,
//   //               bottom: 0,
//   //               right: 24,
//   //             ),
//   //           ),
//   //         );
//   //         await prefs.setBool(seenIntroBoxKey, true);
//   //       },
//   //     );
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Home')),
//       body: Padding(
//         padding: const EdgeInsets.all(8),
//         child: Column(
//           children: [
//             const Padding(
//               padding: EdgeInsets.only(top: 8, bottom: 8),
//               child: Text('This is a map that is showing (51.5, -0.9).'),
//             ),
//             Flexible(
//               child: FlutterMap(
//                 options: MapOptions(
//                   center: const LatLng(51.5, -0.09),
//                   zoom: 5,
//                   maxBounds: LatLngBounds(
//                     const LatLng(-90, -180),
//                     const LatLng(90, 180),
//                   ),
//                 ),
//                 nonRotatedChildren: [
//                   RichAttributionWidget(
//                     popupInitialDisplayDuration: const Duration(seconds: 5),
//                     animationConfig: const ScaleRAWA(),
//                     attributions: [
//                       TextSourceAttribution(
//                         'OpenStreetMap contributors',
//                         // onTap: () => launchUrl(
//                         //   Uri.parse('https://openstreetmap.org/copyright'),
//                         // ),
//                       ),
//                       const TextSourceAttribution(
//                         'This attribution is the same throughout this app, except where otherwise specified',
//                         prependCopyright: false,
//                       ),
//                     ],
//                   ),
//                 ],
//                 children: [
//                   TileLayer(
//                     urlTemplate:
//                         'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                     userAgentPackageName: 'dev.fleaflet.flutter_map.example',
//                   ),
//                   MarkerLayer(
//                     markers: [
//                       Marker(
//                         width: 80,
//                         height: 80,
//                         point: const LatLng(51.5, -0.09),
//                         builder: (ctx) => const FlutterLogo(
//                           textColor: Colors.blue,
//                           key: ObjectKey(Colors.blue),
//                         ),
//                       ),
//                       Marker(
//                         width: 80,
//                         height: 80,
//                         point: const LatLng(53.3498, -6.2603),
//                         builder: (ctx) => const FlutterLogo(
//                           textColor: Colors.green,
//                           key: ObjectKey(Colors.green),
//                         ),
//                       ),
//                       Marker(
//                         width: 80,
//                         height: 80,
//                         point: const LatLng(48.8566, 2.3522),
//                         builder: (ctx) => const FlutterLogo(
//                           textColor: Colors.purple,
//                           key: ObjectKey(Colors.purple),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
