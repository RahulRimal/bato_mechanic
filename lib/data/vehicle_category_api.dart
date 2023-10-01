import 'dart:io';

import 'package:bato_mechanic/models/vehicle_category.dart';
import 'package:bato_mechanic/screens/managers/api_values_manager.dart';
import 'package:http/http.dart' as http;

import '../models/system_models.dart';
import '../screens/managers/strings_manager.dart';
import '../screens/managers/values_manager.dart';

class VehicleCategoryApi {
  static getCategories() async {
    try {
      var url = Uri.parse('${RemoteManager.BASE_URI}categories/');

      var response = await http.get(
        url,
        // headers: {
        //   HttpHeaders.authorizationHeader: "SL " + loggedInUser.accessToken
        // },
      );

      if (response.statusCode == 200) {
        return Success(
            code: response.statusCode,
            response: vehicleCategoriesFromJson(response.body));
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
