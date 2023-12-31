import 'package:bato_mechanic/providers/vehicle_provider.dart';
import 'package:bato_mechanic/presentation/vehicle_category/vehicle_category_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
