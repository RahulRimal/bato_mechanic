import 'package:bato_mechanic/data/vehicle_part_api.dart';
import 'package:bato_mechanic/models/vehicle_part.dart';
import 'package:flutter/material.dart';

import '../models/system_models.dart';

abstract class VehiclePartProvider extends ChangeNotifier {
  List<VehiclePart> _parts = [];
  bool _loading = false;
  VehiclePartError? _vehiclePartError;

  VehiclePart? _selectedVehiclePart;

  List<VehiclePart> get parts => _parts;
  set parts(List<VehiclePart> parts) {
    _parts = parts;
  }

  bool get loading => _loading;
  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  VehiclePartError? get vehiclePartError => _vehiclePartError;
  set vehiclePartError(VehiclePartError? vehiclePartError) {
    _vehiclePartError = vehiclePartError;
  }

  VehiclePart? get selectedVehiclePart => _selectedVehiclePart;
  set selectedVehiclePart(VehiclePart? selectedVehiclePart) {
    _selectedVehiclePart = selectedVehiclePart;
    notifyListeners();
  }

  List<VehiclePart> getVehicleParts(String vehicleId) {
    return parts
        .where((part) => part.vehicleId == int.parse(vehicleId))
        .toList();
  }

  fetchVechicleParts(String vehicleId) async {
    loading = true;
    var response = await VehiclePartApi.getVechicleParts(vehicleId);

    if (response is Success) {
      parts = response.response as List<VehiclePart>;
      // loading = false;
      // return response.response;
    }

    if (response is Failure) {
      vehiclePartError = VehiclePartError(
          code: response.code, message: response.errorResponse);
    }
    loading = false;
  }

  // Future<List<VehiclePart>> getVechicleParts(String vehicleId) async {
  //   loading = true;
  //   List<VehiclePart> vehicleParts =
  //       parts.where((part) => part.vehicleId == int.parse(vehicleId)).toList();
  //   print(vehicleParts);
  //   print('here');
  //   if (vehicleParts.isNotEmpty) return vehicleParts;
  //   var response = await VehiclePartApi.getVechicleParts(vehicleId);
  //   if (response is Success) {
  //     parts = response.response as List<VehiclePart>;
  //     loading = false;
  //     return response.response as List<VehiclePart>;
  //   }
  //   if (response is Failure) {
  //     vehiclePartError = VehiclePartError(
  //         code: response.code, message: response.errorResponse);
  //   }
  //   loading = false;
  //   return [];
  // }
}
