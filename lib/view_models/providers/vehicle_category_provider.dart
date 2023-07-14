import 'package:bato_mechanic/data/vehicle_category_api.dart';
import 'package:bato_mechanic/view_models/base_view_model.dart';
import 'package:bato_mechanic/view_models/vehicle_category_screen_view_model.dart';
import 'package:flutter/material.dart';

import '../../models/system_models.dart';
import '../../models/vehicle_category.dart';

class VehicleCategoryProvider
    with ChangeNotifier, BaseViewModel, VehicleCategoryScreenViewModel {
  List<VehicleCategory> _vehicleCategories = [];
  bool _loading = false;
  VehicleCategoryError? _vehicleCategoryError;
  VehicleCategory? _selectedVehicleCategory;

  List<VehicleCategory> get vehicleCategories => _vehicleCategories;
  set vehicleCategories(List<VehicleCategory> value) {
    _vehicleCategories = value;
  }

  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  VehicleCategoryError? get vehicleCategoryError => _vehicleCategoryError;
  set vehicleCategoryError(VehicleCategoryError? value) {
    _vehicleCategoryError = value;
    // notifyListeners();
  }

  VehicleCategory? get selectedVehicleCategory => _selectedVehicleCategory;
  set selectedVehicleCategory(VehicleCategory? value) {
    _selectedVehicleCategory = value;
    notifyListeners();
  }

  getVechicleCategories() async {
    loading = true;
    var response = await VechicleCategoryApi.getCategories();

    if (response is Success) {
      vehicleCategories = response.response as List<VehicleCategory>;
      // loading = false;
      // return response.response;
    }

    if (response is Failure) {
      vehicleCategoryError = VehicleCategoryError(
          code: response.code, message: response.errorResponse);
    }
    loading = false;
  }
}
