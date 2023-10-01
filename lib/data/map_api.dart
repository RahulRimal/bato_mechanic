import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/system_models.dart';
import '../app/managers/strings_manager.dart';
import '../app/managers/values_manager.dart';

class MapApi {
  static getRoute(String sourcePoint, String destinationPoint) async {
    try {
      var url = Uri.parse(
          'https://api.openrouteservice.org/v2/directions/driving-car?api_key=5b3ce3597851110001cf6248b60a25fd6a3d4feebc3315580a66b8e8&start=$sourcePoint&end=$destinationPoint');

      var response = await http.get(
        url,
        // headers: {
        //   HttpHeaders.authorizationHeader: "SL " + loggedInUser.accessToken
        // },
      );

      print(response);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var listOfCoordinatePoints =
            data['features'][0]['geometry']['coordinates'];

        return listOfCoordinatePoints;
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

  static getSearchLocations(String searchText) async {
    try {
      String url =
          'https://nominatim.openstreetmap.org/search?q=$searchText&format=json&polygon_geojson=1&addressdetails=1&accept-language=en';
      var response = await http.post(Uri.parse(url));

      if (response.statusCode == 200) {
        return Success(
          code: response.statusCode,
          response:
              jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>,
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

  static getLocationName(double latitude, double longitude) async {
    try {
      String url =
          'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1&accept-language=en';
      // var response = await http.post(Uri.parse(url));
      var response = await http.get(Uri.parse(url));

      // if (response.statusCode == 200) {

      //   return json.decode(response.body)['display_name'];
      // } else {
      //   // throw Exception('Failed to get route');
      //   print('Failed to get route');
      // }
      if (response.statusCode == ApiStatusCode.responseSuccess) {
        return Success(
          code: response.statusCode,
          response: json.decode(response.body)['display_name'],
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
