import 'package:bato_mechanic/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

mixin VehiclesScreenViewModel on ChangeNotifier, BaseViewModel {
  bindVSViewModel(BuildContext context, WidgetsBindingObserver observer) {
    bindBaseViewModal(context);
    // Register this object as an observer
    WidgetsBinding.instance.addObserver(observer);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      vehicleProvider.getVechiclesByCategory(
          vehicleCategoryProvider.selectedVehicleCategory!.id.toString());
    });
  }

  unBindVSViewModel(WidgetsBindingObserver observer) {
    unBindBaseViewModal();
    // Unregister this object as an observer
    WidgetsBinding.instance.removeObserver(observer);
  }
}
