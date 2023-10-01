import 'dart:convert';
import 'dart:io';

import 'package:bato_mechanic/models/vehicle_repair_request.dart';

import '../models/system_models.dart';
import '../presentation/managers/api_values_manager.dart';
import 'package:http/http.dart' as http;

import '../presentation/managers/strings_manager.dart';
import '../presentation/managers/values_manager.dart';

class VehicleRepairRequestApi {
  static getVechicleRepairRequest(String repairRequestId) async {
    try {
      var url = Uri.parse(
          '${RemoteManager.BASE_URI}repair_requests/$repairRequestId/');

      var response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        return Success(
          code: response.statusCode,
          response: vehicleRepairRequestFromJson(response.body),
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

  static requestForVehicleRepair(Map<String, dynamic> requestInfo) async {
    try {
      var url = Uri.parse('${RemoteManager.BASE_URI}repair_requests/');

      var response = await http.post(
        url,
        headers: {
          "Accept": "application/json; charset=utf-8",

          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Access-Control-Allow-Methods": "POST, GET, OPTIONS",
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: json.encode(requestInfo),
      );

      if (response.statusCode == ApiStatusCode.responseCreated) {
        return Success(
            code: response.statusCode,
            response: vehicleRepairRequestFromJson(response.body));
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

  static addImagesToRepairRequest(
      String repairRequestId, List<File> images) async {
    try {
      var url = Uri.parse(
          '${RemoteManager.BASE_URI}/repair_requests/$repairRequestId/images/');

      var request = http.MultipartRequest("POST", url);

      for (var i = 0; i < images.length; i++) {
        var pic = await http.MultipartFile.fromPath(
          'images',
          // 'image ${i + 1}',
          images[i].path,
        );
        request.files.add(pic);
      }

      request.headers.addAll({
        // HttpHeaders.authorizationHeader: "SL " + loggedinSession.accessToken,
        "Accept": "application/json; charset=utf-8",
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Methods": "POST, GET, OPTIONS",
      });

      var response = await request.send();

      //Get the response from the server
      var responseData = await response.stream.toBytes();

      var responseBody = String.fromCharCodes(responseData);

      if (response.statusCode == ApiStatusCode.responseCreated) {
        return await getVechicleRepairRequest(repairRequestId);
      }
      return Failure(
          code: ApiStatusCode.invalidResponse,
          // errorResponse: ApiStrings.invalidResponseString
          // errorResponse: response.body);
          errorResponse: response.stream.toString());
    } on HttpException {
      return Failure(
          code: ApiStatusCode.httpError,
          errorResponse: ApiStrings.noInternetString);
    } on FormatException {
      return Failure(
          code: ApiStatusCode.invalidResponse,
          errorResponse: ApiStrings.invalidFormatString);
    } catch (e) {
      return Failure(code: 103, errorResponse: e.toString());
      // return Failure(
      //     code: ApiStatusCode.unknownError,
      //     errorResponse: ApiStrings.unknownErrorString);
    }
  }
}
