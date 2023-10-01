import 'package:bato_mechanic/models/vehicle_part.dart';
import 'package:bato_mechanic/view_models/base_view_model_old.dart';
import 'package:bato_mechanic/view_models/providers/vehicle_part_provider.dart';
import 'package:bato_mechanic/view_models/providers/vehicle_provider.dart';
import 'package:bato_mechanic/view_models/vehicle_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehiclePartsScreenViewModel extends VehiclePartProvider
    with VehiclePartsScreenViewModelInputs, VehiclePartsScreenViewModelOutputs {
  // late VehicleProvider vehicleProvider;
  late VehiclesScreenViewModel _vehicleViewModel;
  init(BuildContext context) {
    _vehicleViewModel =
        Provider.of<VehiclesScreenViewModel>(context, listen: false);
    if (super
        .getVehicleParts(_vehicleViewModel.selectedVehicle!.id.toString())
        .isEmpty) {
      super
          .fetchVechicleParts(_vehicleViewModel.selectedVehicle!.id.toString());
    }
  }
}

mixin VehiclePartsScreenViewModelInputs {}

mixin VehiclePartsScreenViewModelOutputs {}
