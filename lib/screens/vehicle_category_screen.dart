import 'package:bato_mechanic/screens/vehicle_parts_screen.dart';
import 'package:bato_mechanic/screens/vehicles_screen.dart';
import 'package:bato_mechanic/view_models/providers/vehicle_category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/vehicle_category.dart';

class VehicleCategoryScreen extends StatefulWidget {
  const VehicleCategoryScreen({super.key});

  @override
  State<VehicleCategoryScreen> createState() => _VehicleCategoryScreenState();
}

class _VehicleCategoryScreenState extends State<VehicleCategoryScreen>
    with WidgetsBindingObserver {
  late VehicleCategoryProvider _vehicleCategoryProvider;

  @override
  void initState() {
    super.initState();

    _vehicleCategoryProvider =
        Provider.of<VehicleCategoryProvider>(context, listen: false);

    _vehicleCategoryProvider.bindVCSViewModel(context, this);

    // // Register this object as an observer
    // WidgetsBinding.instance.addObserver(this);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (_vehicleCategoryProvider.vehicleCategories.isEmpty) {
    //     _vehicleCategoryProvider.getVechicleCategories();
    //   }
    // });
  }

  @override
  void dispose() {
    _vehicleCategoryProvider.unBindVCSViewModel(this);
    // // Unregister this object as an observer
    // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List<VehicleCategory> vehicleCategories = [
    //   VehicleCategory(
    //     name: 'Bike',
    //     image: 'assets/images/vehicle/bike.png',
    //     type: '2 wheeler',
    //     tagLine: 'Two wheeler',
    //   ),
    //   VehicleCategory(
    //     name: 'Car',
    //     image: 'assets/images/vehicle/car.png',
    //     type: '4 wheeler',
    //     tagLine: 'Small four wheeler',
    //   ),
    //   VehicleCategory(
    //     name: 'Bus',
    //     image: 'assets/images/vehicle/bus.png',
    //     type: '4 wheeler',
    //     tagLine: 'Four wheeler',
    //   ),
    //   VehicleCategory(
    //     name: 'Semi',
    //     image: 'assets/images/vehicle/semi.png',
    //     type: '4 wheeler',
    //     tagLine: 'Heavy Four wheeler',
    //   ),
    //   VehicleCategory(
    //     name: 'Machinary',
    //     image: 'assets/images/vehicle/jcb.png',
    //     type: '4 wheeler',
    //     tagLine: 'Heavy four wheeler',
    //   ),
    // ];

    VehicleCategoryProvider vehicleCategoryProvider =
        context.watch<VehicleCategoryProvider>();

    return Scaffold(
      body: vehicleCategoryProvider.loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 200,
                      ),
                      const Text(
                        'Select your vehicle type',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount:
                            vehicleCategoryProvider.vehicleCategories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            vehicleCategoryProvider.selectedVehicleCategory =
                                vehicleCategoryProvider
                                    .vehicleCategories[index];
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const VehiclesScreen()));
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    vehicleCategoryProvider
                                        .vehicleCategories[index].image,
                                    width: 150,
                                  ),
                                  // Image.asset(
                                  //   vehicleCategoryProvider
                                  //       .vehicleCategories[index].image,
                                  //   width: 100,
                                  // ),
                                  Flexible(
                                    child: Text(
                                      vehicleCategoryProvider
                                          .vehicleCategories[index].name,
                                      overflow: TextOverflow.visible,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  // Text(
                                  //   // 'Small four wheeler',
                                  //   vehicleCategories[index].tagLine,
                                  //   style: const TextStyle(
                                  //     fontSize: 12,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // )
                                ]),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
    );
  }
}
