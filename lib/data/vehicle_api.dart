import 'dart:io';

import 'package:bato_mechanic/models/vehicle.dart';

import '../models/system_models.dart';
import '../app/managers/api_values_manager.dart';
import 'package:http/http.dart' as http;

import '../app/managers/strings_manager.dart';
import '../app/managers/values_manager.dart';

class VehicleApi {
  static getVechiclesByCategory(String categoryId) async {
    try {
      var url = Uri.parse(
          '${RemoteManager.BASE_URI}vehicles/?category_id=$categoryId');

      var response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        return Success(
            code: response.statusCode,
            response: vehiclesFromJson(response.body));
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
