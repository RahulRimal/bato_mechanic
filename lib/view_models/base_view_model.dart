import 'package:bato_mechanic/models/vehicle_repair_request.dart';
import 'package:bato_mechanic/view_models/providers/system_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'map_search_widget_view_model.dart';
import 'vehicle_category_screen_view_model.dart';
import 'vehicle_parts_screen_view_model.dart';
import 'vehicle_repair_request_view_model.dart';
import 'vehicle_screen_view_model.dart';

mixin BaseViewModel {
  late SystemProvider systemProvider;
  late MapSearchWidgetViewModel mapViewModel;
  late VehicleCategoryScreenViewModel vehicleCategoryViewModel;
  late VehiclesScreenViewModel vehicleViewModel;
  late VehiclePartsScreenViewModel vehiclePartViewModel;
  late VehicleRepairRequestViewModel vehicleRepairRequestViewModel;
  initViewModels(BuildContext context) {
    systemProvider = Provider.of<SystemProvider>(context, listen: false);
    mapViewModel =
        Provider.of<MapSearchWidgetViewModel>(context, listen: false);
    vehicleCategoryViewModel =
        Provider.of<VehicleCategoryScreenViewModel>(context, listen: false);
    vehicleViewModel =
        Provider.of<VehiclesScreenViewModel>(context, listen: false);
    vehiclePartViewModel =
        Provider.of<VehiclePartsScreenViewModel>(context, listen: false);
    vehicleRepairRequestViewModel =
        Provider.of<VehicleRepairRequestViewModel>(context, listen: false);
  }
}
