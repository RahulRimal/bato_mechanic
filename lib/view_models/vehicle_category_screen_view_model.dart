import 'package:bato_mechanic/data/vehicle_category_api.dart';

import 'providers/vehicle_category_provider.dart';

class VehicleCategoryScreenViewModel extends VehicleCategoryProvider with VehicleCategoryScreenViewModelInputs, VehicleCategoryScreenViewModelOutputs{


  init(){
    super.getVechicleCategories();
  }
  
}

mixin VehicleCategoryScreenViewModelInputs{
}

mixin VehicleCategoryScreenViewModelOutputs{
  
}
