import 'package:bato_mechanic/data/vehicle_category_api.dart';
import 'package:bato_mechanic/view_models/providers/vehicle_repair_request_provider.dart';

import 'providers/vehicle_category_provider.dart';

class VehicleRepairRequestViewModel extends VehicleRepairRequestProvider
    with
        VehicleCategoryScreenViewModelInputs,
        VehicleCategoryScreenViewModelOutputs {
  init() {}
}

mixin VehicleCategoryScreenViewModelInputs {}

mixin VehicleCategoryScreenViewModelOutputs {}
