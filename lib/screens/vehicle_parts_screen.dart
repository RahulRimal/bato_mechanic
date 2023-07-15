import 'package:bato_mechanic/models/vehicle_part.dart';
import 'package:bato_mechanic/screens/request_mechanic_screen.dart';
import 'package:bato_mechanic/view_models/providers/vehicle_part_provider.dart';
import 'package:bato_mechanic/view_models/providers/vehicle_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/vehicle.dart';
import 'track_mechanic_screen.dart';

class VehiclePartsScreen extends StatefulWidget {
  const VehiclePartsScreen({super.key});

  @override
  State<VehiclePartsScreen> createState() => _VehiclePartsScreenState();
}

class _VehiclePartsScreenState extends State<VehiclePartsScreen>
    with WidgetsBindingObserver {
  late VehiclePartProvider _vehiclePartProvider;

  @override
  void initState() {
    super.initState();
    _vehiclePartProvider =
        Provider.of<VehiclePartProvider>(context, listen: false);
    _vehiclePartProvider.bindVPSViewModel(context, this);
  }

  @override
  void dispose() {
    _vehiclePartProvider.unBindVPSViewModel(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List<PartsCategory> categories = [
    //   PartsCategory(
    //     name: 'Wheels',
    //     image: 'assets/images/parts/wheel.png',
    //   ),
    //   PartsCategory(
    //     name: 'Engine',
    //     image: 'assets/images/parts/engine.png',
    //   ),
    //   PartsCategory(
    //     name: 'Electricity',
    //     image: 'assets/images/parts/electricity.png',
    //   ),
    //   PartsCategory(
    //     name: 'Body',
    //     image: 'assets/images/parts/body.png',
    //   ),
    //   PartsCategory(
    //     name: 'Accessories',
    //     image: 'assets/images/parts/accessories.png',
    //   ),
    // ];

    VehiclePartProvider _vehiclePartProvider =
        context.watch<VehiclePartProvider>();

    return Scaffold(
      // backgroundColor: Colors.amber[800],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 200,
            ),
            const Text(
              'Where is the problem being occured?',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            GridView.builder(
              shrinkWrap: true,

              // itemCount: _vehiclePartProvider.parts.length,
              itemCount: _vehiclePartProvider
                  .getVehicleParts(_vehiclePartProvider
                      .vehicleProvider.selectedVehicle!.id
                      .toString())
                  .length,

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                List<VehiclePart> vehicleParts =
                    _vehiclePartProvider.getVehicleParts(_vehiclePartProvider
                        .vehicleProvider.selectedVehicle!.id
                        .toString());
                return GestureDetector(
                  onTap: () {
                    _vehiclePartProvider.selectedVehiclePart =
                        vehicleParts[index];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RequestMechanicScreen(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.amberAccent[200],
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image.asset(
                        //   // categories[index].image,
                        //   _vehiclePartProvider.parts[index].image,

                        //   width: 100,
                        // ),
                        Image.network(
                          // categories[index].image,
                          vehicleParts[index].image,

                          width: 100,
                        ),
                        Text(
                          // categories[index].name,
                          vehicleParts[index].name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}

// class PartsCategory {
//   PartsCategory({required this.name, required this.image});
//   String name;
//   String image;
// }
