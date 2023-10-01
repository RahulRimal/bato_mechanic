import 'package:bato_mechanic/screens/managers/values_manager.dart';
import 'package:bato_mechanic/screens/vehicles_screen.dart';
import 'package:bato_mechanic/utils/system_helper.dart';
import 'package:bato_mechanic/view_models/vehicle_category_screen_view_model.dart';
import 'package:bato_mechanic/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehicleCategoryScreen extends StatefulWidget {
  const VehicleCategoryScreen({super.key});

  @override
  State<VehicleCategoryScreen> createState() => _VehicleCategoryScreenState();
}

class _VehicleCategoryScreenState extends State<VehicleCategoryScreen>
    with WidgetsBindingObserver {
  late VehicleCategoryScreenViewModel _vehicleCategoryViewModel;

  @override
  void initState() {
    super.initState();
    // Register this object as an observer
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _vehicleCategoryViewModel =
          Provider.of<VehicleCategoryScreenViewModel>(context, listen: false);
      _vehicleCategoryViewModel.init();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    VehicleCategoryScreenViewModel vehicleCategoryViewModel =
        context.watch<VehicleCategoryScreenViewModel>();

    return Scaffold(
      appBar: AppBar(),
      drawer: const AppDrawer(),
      body: _buildUI(vehicleCategoryViewModel),
    );
  }

  _buildUI(VehicleCategoryScreenViewModel vehicleCategoryViewModel) {
    if (vehicleCategoryViewModel.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (vehicleCategoryViewModel.vehicleCategoryError != null) {
      return Center(
        child: Text(
          vehicleCategoryViewModel.vehicleCategoryError!.message.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      );
    }
    if (vehicleCategoryViewModel.vehicleCategories.isEmpty) {
      return const Center(
        child: Text(
          "No vehicle category found",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 180),
        Text(
          'Select your vehicle type',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        GridView.builder(
          shrinkWrap: true,
          itemCount: vehicleCategoryViewModel.vehicleCategories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              vehicleCategoryViewModel.selectedVehicleCategory =
                  vehicleCategoryViewModel.vehicleCategories[index];
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const VehiclesScreen()));
            },
            child: Card(
              margin: const EdgeInsets.all(AppMargin.m18),
              child: Padding(
                padding: const EdgeInsets.all(AppMargin.m8),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        vehicleCategoryViewModel.vehicleCategories[index].image,
                        width: 150,
                      ),
                      Flexible(
                        child: Text(
                          vehicleCategoryViewModel.vehicleCategories[index].name
                              .capitalize(),
                          overflow: TextOverflow.visible,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
