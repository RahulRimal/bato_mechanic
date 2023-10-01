import 'package:bato_mechanic/models/vehicle_category.dart';
import 'package:bato_mechanic/view_models/base_view_model_old.dart';
import 'package:bato_mechanic/view_models/providers/vehicle_category_provider.dart';
import 'package:bato_mechanic/view_models/providers/vehicle_part_provider.dart';
import 'package:bato_mechanic/view_models/providers/vehicle_provider.dart';
import 'package:bato_mechanic/view_models/vehicle_category_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/vehicle_part.dart';

// mixin VehiclesScreenViewModel on ChangeNotifier, BaseViewModel {
//   bindVSViewModel(BuildContext context, WidgetsBindingObserver observer) {
//     bindBaseViewModal(context);
//     // Register this object as an observer
//     WidgetsBinding.instance.addObserver(observer);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       vehicleProvider.getVechiclesByCategory(
//           vehicleCategoryProvider.selectedVehicleCategory!.id.toString());
//     });
//   }

//   unBindVSViewModel(WidgetsBindingObserver observer) {
//     unBindBaseViewModal();
//     // Unregister this object as an observer
//     WidgetsBinding.instance.removeObserver(observer);
//   }
// }

class VehiclesScreenViewModel extends VehicleProvider {
  // late VehicleCategory _vehicleCategoryProvider;
  late VehicleCategoryScreenViewModel _vehicleCategoryViewModel;

  init(BuildContext ctx) {
    // _vehicleCategoryProvider = Provider.of<VehicleCategory>(ctx, listen: false);

    _vehicleCategoryViewModel =
        Provider.of<VehicleCategoryScreenViewModel>(ctx, listen: false);

    super.getVechiclesByCategory(
        _vehicleCategoryViewModel.selectedVehicleCategory!.id.toString());
  }

  // List<VehiclePart> getVehicleParts(){

  // }
}

mixin VehiclesScreenViewModelInputs {}

mixin VehiclesScreenViewModelOutputs {}
