import 'package:bato_mechanic/view_models/providers/vehicle_category_provider.dart';
import 'package:bato_mechanic/view_models/providers/vehicle_part_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/map_provider.dart';
import 'providers/vehicle_provider.dart';

mixin BaseViewModel on ChangeNotifier {
  late MapProvider mapProvider;
  late VehicleCategoryProvider vehicleCategoryProvider;
  late VehicleProvider vehicleProvider;
  late VehiclePartProvider vehiclePartProvider;

  // Future<SharedPreferences> preferences = SharedPreferences.getInstance();

  bindBaseViewModal(BuildContext context) {
    mapProvider = Provider.of<MapProvider>(context, listen: false);
    vehicleCategoryProvider =
        Provider.of<VehicleCategoryProvider>(context, listen: false);
    vehicleProvider = Provider.of<VehicleProvider>(context, listen: false);
    vehiclePartProvider =
        Provider.of<VehiclePartProvider>(context, listen: false);
  }

  unBindBaseViewModal() {}
}
