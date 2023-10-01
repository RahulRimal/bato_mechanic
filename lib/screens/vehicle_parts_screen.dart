import 'package:bato_mechanic/models/vehicle_part.dart';
import 'package:bato_mechanic/screens/request_mechanic_screen.dart';
import 'package:bato_mechanic/view_models/providers/vehicle_part_provider.dart';
import 'package:bato_mechanic/view_models/providers/vehicle_provider.dart';
import 'package:bato_mechanic/view_models/vehicle_parts_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/vehicle.dart';
import 'managers/values_manager.dart';
import 'track_mechanic_screen.dart';

class VehiclePartsScreen extends StatefulWidget {
  const VehiclePartsScreen({super.key});

  @override
  State<VehiclePartsScreen> createState() => _VehiclePartsScreenState();
}

class _VehiclePartsScreenState extends State<VehiclePartsScreen>
    with WidgetsBindingObserver {
  late VehiclePartsScreenViewModel _vehiclePartsViewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _vehiclePartsViewModel =
          Provider.of<VehiclePartsScreenViewModel>(context, listen: false);
      _vehiclePartsViewModel.init(context);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    VehiclePartsScreenViewModel vehiclePartsViewModel =
        context.watch<VehiclePartsScreenViewModel>();

    return Scaffold(body: _buildUI(vehiclePartsViewModel));
  }

  _buildUI(VehiclePartsScreenViewModel vehiclePartsViewModel) {
    if (vehiclePartsViewModel.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (vehiclePartsViewModel.vehiclePartError != null) {
      return Center(
        child: Text(vehiclePartsViewModel.vehiclePartError!.message.toString()),
      );
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 200,
          ),
          Text(
            'Where is the problem being occured?',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          GridView.builder(
            shrinkWrap: true,
            itemCount: vehiclePartsViewModel.parts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  vehiclePartsViewModel.selectedVehiclePart =
                      vehiclePartsViewModel.parts[index];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RequestMechanicScreen(),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.all(AppMargin.m8),
                  child: Padding(
                    padding: const EdgeInsets.all(AppMargin.m8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          vehiclePartsViewModel.parts[index].image,
                          width: 100,
                        ),
                        Text(
                          vehiclePartsViewModel.parts[index].name,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}
