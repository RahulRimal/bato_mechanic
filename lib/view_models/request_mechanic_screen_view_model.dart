import 'package:bato_mechanic/models/vehicle.dart';
import 'package:bato_mechanic/view_models/base_view_model.dart';
import 'package:bato_mechanic/view_models/map_search_widget_view_model.dart';
import 'package:flutter/material.dart';

import '../models/vehicle_category.dart';

mixin RequestMechanicScreenViewModel
    on ChangeNotifier, BaseViewModel, MapSearchWidgetViewModel {
  // VehicleCategory? _selectedVehicleCategory;
  // Vehicle? _selectedVehicle;

  // VehicleCategory? get rmsSelectedVehicleCategory => _selectedVehicleCategory;
  // set rmsSelectedVehicleCategory(VehicleCategory? value) {
  //   _selectedVehicleCategory = value;
  //   notifyListeners();
  // }

  // Vehicle? get rmsSelectedVehicle => _selectedVehicle;
  // set rmsSelectedVehicle(Vehicle? value) {
  //   _selectedVehicle = value;
  //   notifyListeners();
  // }

  bindRMSViewModel(BuildContext context) {
    bindBaseViewModal(context);
    // bindMSWViewModel(context, this);
  }

  unBindRMSViewModel() {
    unBindBaseViewModal();
    // unBindMSWViewModel();
  }
}
