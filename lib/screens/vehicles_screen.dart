import 'package:bato_mechanic/view_models/providers/vehicle_category_provider.dart';
import 'package:bato_mechanic/view_models/providers/vehicle_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/vehicle.dart';
import '../models/vehicle_category.dart';
import 'vehicle_parts_screen.dart';

class VehiclesScreen extends StatefulWidget {
  const VehiclesScreen({super.key});

  @override
  State<VehiclesScreen> createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends State<VehiclesScreen>
    with WidgetsBindingObserver {
  late VehicleProvider _vehicleProvider;

  @override
  void initState() {
    super.initState();
    _vehicleProvider = Provider.of<VehicleProvider>(context, listen: false);
    _vehicleProvider.bindVSViewModel(context, this);
  }

  @override
  void dispose() {
    _vehicleProvider.unBindVSViewModel(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    VehicleProvider vehicleProvider = context.watch<VehicleProvider>();
    return Scaffold(
      // backgroundColor: Colors.amber[800],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 200,
              ),
              const Text(
                'Select your vehicle to repair',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              if (vehicleProvider.loading)
                Center(
                  child: CircularProgressIndicator(),
                )
              else
                GridView.builder(
                  shrinkWrap: true,
                  // itemCount: vehicles.length,
                  itemCount: vehicleProvider.vehicles.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      vehicleProvider.selectedVehicle =
                          vehicleProvider.vehicles[index];
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const VehiclePartsScreen()));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      width: 50,
                      // height: 200,
                      decoration: BoxDecoration(
                        color: Colors.amberAccent[200],
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image.asset('images/car.png'),
                            // Image.asset(
                            //   // vehicles[index].image,
                            //   _vehicleProvider.vehicles[index].image,
                            //   width: 100,
                            // ),
                            Image.network(
                              vehicleProvider.vehicles[index].image,
                              // width: 100,
                            ),

                            Flexible(
                              child: Text(
                                vehicleProvider.vehicles[index].name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // Text(
                            //   // 'Small four wheeler',
                            //   vehicles[index].tagLine,
                            //   style: const TextStyle(
                            //     fontSize: 12,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // )
                          ]),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
