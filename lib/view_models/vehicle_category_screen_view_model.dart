import 'providers/vehicle_category_provider.dart';

class VehicleCategoryScreenViewModel extends VehicleCategoryProvider
    with
        VehicleCategoryScreenViewModelInputs,
        VehicleCategoryScreenViewModelOutputs {
  init() {
    super.getVechicleCategories();
  }
}

mixin VehicleCategoryScreenViewModelInputs {}

mixin VehicleCategoryScreenViewModelOutputs {}
