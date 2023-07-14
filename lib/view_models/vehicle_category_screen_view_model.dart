import 'package:bato_mechanic/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

mixin VehicleCategoryScreenViewModel on ChangeNotifier, BaseViewModel {
  bindVCSViewModel(
      BuildContext context, WidgetsBindingObserver widgetsBindingObserver) {
    bindBaseViewModal(context);
    // Register this object as an observer
    WidgetsBinding.instance.addObserver(widgetsBindingObserver);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (vehicleCategoryProvider.vehicleCategories.isEmpty) {
        vehicleCategoryProvider.getVechicleCategories();
      }
    });
  }

  unBindVCSViewModel(WidgetsBindingObserver widgetsBindingObserver) {
    unBindBaseViewModal();
    // Unregister this object as an observer
    WidgetsBinding.instance.removeObserver(widgetsBindingObserver);
  }
}
