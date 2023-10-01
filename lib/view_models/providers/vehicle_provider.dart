import 'package:bato_mechanic/data/vehicle_api.dart';
import 'package:bato_mechanic/view_models/base_view_model_old.dart';
import 'package:bato_mechanic/view_models/vehicle_screen_view_model.dart';
import 'package:flutter/material.dart';

import '../../models/system_models.dart';
import '../../models/vehicle.dart';

abstract class VehicleProvider
    extends ChangeNotifier{
  List<Vehicle> _vehicles = [];
  bool _loading = false;
  VehicleError? _vehicleError;

  Vehicle? _selectedVehicle;

  List<Vehicle> get vehicles => _vehicles;
  set vehicles(List<Vehicle> vehicles) {
    _vehicles = vehicles;
  }

  bool get loading => _loading;
  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  VehicleError? get vehicleError => _vehicleError;
  set vehicleError(VehicleError? vehicleError) {
    _vehicleError = vehicleError;
    // notifyListeners();
  }

  Vehicle? get selectedVehicle => _selectedVehicle;
  set selectedVehicle(Vehicle? selectedVehicle) {
    _selectedVehicle = selectedVehicle;
    notifyListeners();
  }

  addVehicle(Vehicle vehicle) {
    _vehicles.add(vehicle);
    // notifyListeners();
  }

  getVechiclesByCategory(String categoryId) async {
    loading = true;
    var response = await VehicleApi.getVechiclesByCategory(categoryId);

    if (response is Success) {
      vehicles = response.response as List<Vehicle>;
    }

    if (response is Failure) {
      vehicleError =
          VehicleError(code: response.code, message: response.errorResponse);
    }
    loading = false;
  }
}
