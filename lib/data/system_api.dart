import 'dart:convert';

import 'package:http/http.dart' as http;

class SystemApi {
  static getRoute(String sourcePoint, String destinationPoint) async {
    var url = Uri.parse(
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=5b3ce3597851110001cf6248b60a25fd6a3d4feebc3315580a66b8e8&start=$sourcePoint&end=$destinationPoint');

    var response = await http.get(
      url,
      // headers: {
      //   HttpHeaders.authorizationHeader: "SL " + loggedInUser.accessToken
      // },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var listOfCoordinatePoints =
          data['features'][0]['geometry']['coordinates'];

      return listOfCoordinatePoints;
    } else {
      // throw Exception('Failed to get route');
      print('Failed to get route');
    }
  }
}
