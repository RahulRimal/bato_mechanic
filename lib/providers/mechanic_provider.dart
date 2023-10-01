import 'package:bato_mechanic/data/mechanic_api.dart';
import 'package:flutter/material.dart';

import '../models/mechanic.dart';
import '../models/system_models.dart';

abstract class MechanicProvider extends ChangeNotifier {
  List<Mechanic> _mechanics = [];
  bool _loading = false;
  MechanicError? _mechanicError;

  List<Mechanic> get mechanics => _mechanics;
  set mechanics(List<Mechanic> mechanics) {
    _mechanics = mechanics;
    // notifyListeners();
  }

  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  MechanicError? get mechanicError => _mechanicError;
  set mechanicError(MechanicError? value) {
    _mechanicError = value;
  }

  fetchRecomendedMechanics(
      String vehicleSpeciality, String vehiclePartSpeciality) async {
    loading = true;
    var response = await MechanicApi.getRecomendedMechanics(
        vehicleSpeciality, vehiclePartSpeciality);

    if (response is Success) {
      loading = false;

      return response.response as List<Mechanic>;
    }

    if (response is Failure) {
      mechanicError =
          MechanicError(code: response.code, message: response.errorResponse);
    }
    loading = false;
    return [];
  }
}
