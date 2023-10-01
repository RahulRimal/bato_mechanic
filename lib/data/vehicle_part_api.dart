import 'dart:io';

import 'package:bato_mechanic/models/vehicle_part.dart';

import '../models/system_models.dart';
import '../presentation/managers/api_values_manager.dart';
import 'package:http/http.dart' as http;

import '../presentation/managers/strings_manager.dart';
import '../presentation/managers/values_manager.dart';

class VehiclePartApi {
  static getVechicleParts(String vehicleId) async {
    try {
      var url =
          Uri.parse('${RemoteManager.BASE_URI}vehicles/$vehicleId/parts/');

      var response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        return Success(
          code: response.statusCode,
          response: vehiclePartsFromJson(response.body),
        );
      }
      return Failure(
        code: ApiStatusCode.invalidResponse,
        errorResponse: ApiStrings.invalidResponseString,
      );
    } on HttpException {
      return Failure(
        code: ApiStatusCode.httpError,
        errorResponse: ApiStrings.noInternetString,
      );
    } on FormatException {
      return Failure(
        code: ApiStatusCode.invalidResponse,
        errorResponse: ApiStrings.invalidFormatString,
      );
    } catch (e) {
      // return Failure(code: 103, errorResponse: e.toString());
      return Failure(
        code: ApiStatusCode.unknownError,
        errorResponse: ApiStrings.unknownErrorString,
      );
    }
  }
}
