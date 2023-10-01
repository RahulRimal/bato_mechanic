import 'package:bato_mechanic/screens/managers/values_manager.dart';
import 'package:bato_mechanic/view_models/vehicle_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'vehicle_parts_screen.dart';

class VehiclesScreen extends StatefulWidget {
  const VehiclesScreen({super.key});

  @override
  State<VehiclesScreen> createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends State<VehiclesScreen>
    with WidgetsBindingObserver {
  late VehiclesScreenViewModel _vehiclesViewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _vehiclesViewModel =
          Provider.of<VehiclesScreenViewModel>(context, listen: false);
      _vehiclesViewModel.init(context);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    VehiclesScreenViewModel vehiclesViewModel =
        context.watch<VehiclesScreenViewModel>();
    return Scaffold(
      body: _buildUI(vehiclesViewModel),
    );
  }

  _buildUI(VehiclesScreenViewModel vehiclesViewModel) {
    if (vehiclesViewModel.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (vehiclesViewModel.vehicleError != null) {
      return Center(
        child: Text(vehiclesViewModel.vehicleError!.message.toString()),
      );
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 200,
            ),
            Text(
              'Select your vehicle to repair',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: vehiclesViewModel.vehicles.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  vehiclesViewModel.selectedVehicle =
                      vehiclesViewModel.vehicles[index];
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VehiclePartsScreen()));
                },
                child: Card(
                  margin: const EdgeInsets.all(AppMargin.m8),
                  child: Padding(
                    padding: const EdgeInsets.all(AppMargin.m8),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            vehiclesViewModel.vehicles[index].image,
                            // width: 100,
                          ),

                          Flexible(
                            child: Text(
                              vehiclesViewModel.vehicles[index].name,
                              style: Theme.of(context).textTheme.displaySmall,
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
            ),
          ],
        ),
      ),
    );
  }
}
