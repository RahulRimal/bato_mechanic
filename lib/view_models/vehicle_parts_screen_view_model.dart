import 'package:bato_mechanic/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

mixin VehiclePartsScreenViewModel on ChangeNotifier, BaseViewModel {
  bindVPSViewModel(BuildContext context, WidgetsBindingObserver observer) {
    bindBaseViewModal(context);

    // Register this object as an observer
    // WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addObserver(observer);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (vehiclePartProvider
          .getVehicleParts(vehicleProvider.selectedVehicle!.id.toString())
          .isEmpty) {
        vehiclePartProvider
            .fetchVechicleParts(vehicleProvider.selectedVehicle!.id.toString());
      }
    });
  }

  unBindVPSViewModel(WidgetsBindingObserver observer) {
    unBindBaseViewModal();
    // Unregister this object as an observer
    WidgetsBinding.instance.removeObserver(observer);
  }
}
