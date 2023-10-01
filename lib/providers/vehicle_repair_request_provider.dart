import 'dart:io';

import 'package:flutter/material.dart';

import '../data/vehicle_repair_request_api.dart';
import '../models/system_models.dart';
import '../models/vehicle_repair_request.dart';

abstract class VehicleRepairRequestProvider with ChangeNotifier {
  List<VehicleRepairRequest> _vehicleRepairRequests = [];
  bool _loading = false;
  VehicleRepairRequestError? _vehicleRepairRequestError;

  List<VehicleRepairRequest> get vehicleRepairRequests =>
      _vehicleRepairRequests;
  set vehicleRepairRequests(List<VehicleRepairRequest> vehicleRequests) {
    _vehicleRepairRequests = vehicleRequests;
    // notifyListeners();
  }

  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  VehicleRepairRequestError? get vehicleRepairRequestError =>
      _vehicleRepairRequestError;
  set vehicleRepairRequestError(VehicleRepairRequestError? value) {
    _vehicleRepairRequestError = value;
    // notifyListeners();
  }

  createVehicleRepairRequest(Map<String, dynamic> requestInfo) async {
    loading = true;

    var response =
        await VehicleRepairRequestApi.requestForVehicleRepair(requestInfo);

    if (response is Success) {
      VehicleRepairRequest repairRequest =
          response.response as VehicleRepairRequest;
      _vehicleRepairRequests.add(repairRequest);
      loading = false;
      return true;
    }
    if (response is Failure) {
      vehicleRepairRequestError = VehicleRepairRequestError(
        code: response.code,
        message: response.errorResponse,
      );
    }
    loading = false;
    return false;
  }

  addImagesToVechicleRepairRequest(String requestId, List<File> images) async {
    loading = true;
    var response = await VehicleRepairRequestApi.addImagesToRepairRequest(
        requestId, images);
    if (response is Success) {
      int index = _vehicleRepairRequests
          .indexWhere((item) => item.id.toString() == requestId);
      if (index != -1) {
        _vehicleRepairRequests[index] =
            response.response as VehicleRepairRequest;
      }
      loading = false;
      return true;
    }

    if (response is Failure) {
      vehicleRepairRequestError = VehicleRepairRequestError(
        code: response.code,
        message: response.errorResponse,
      );
    }
    loading = false;
    return false;
  }

  // requestForVehicleRepair(
  //     Map<String, dynamic> requestInfo, List<File> images) async {
  //   loading = true;
  //   var response =
  //       await VehicleRepairRequestApi.requestForVehicleRepair(requestInfo);
  //   if (response is Success) {
  //     VehicleRepairRequest repairRequest =
  //         response.response as VehicleRepairRequest;
  //     _vehicleRepairRequests.add(repairRequest);
  //     var responseWithImages =
  //         await VehicleRepairRequestApi.addImagesToRepairRequest(
  //             repairRequest.id.toString(), images);
  //     if (responseWithImages is Success) {
  //       int index = _vehicleRepairRequests
  //           .indexWhere((item) => item.id == repairRequest.id);
  //       if (index != -1) {
  //         _vehicleRepairRequests[index] =
  //             responseWithImages.response as VehicleRepairRequest;
  //       }
  //     }
  //     if (responseWithImages is Failure) {
  //       vehicleRepairRequestError = VehicleRepairRequestError(
  //         code: response.code,
  //         message: responseWithImages.errorResponse,
  //       );
  //     }
  //   }
  //   if (response is Failure) {
  //     vehicleRepairRequestError = VehicleRepairRequestError(
  //       code: response.code,
  //       message: response.errorResponse,
  //     );
  //   }
  //   loading = false;
  // }
}
