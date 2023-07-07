import 'dart:convert';

import 'package:http/http.dart' as http;

class MapApi {
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

  static getSearchLocations(String searchText) async {
    try {
      String url =
          'https://nominatim.openstreetmap.org/search?q=$searchText&format=json&polygon_geojson=1&addressdetails=1&accept-language=en';
      var response = await http.post(Uri.parse(url));

      if (response.statusCode == 200) {
        var decodedResponse =
            jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;

        return decodedResponse;
      } else {
        // throw Exception('Failed to get route');
        print('Failed to get route');
      }

      // _options = decodedResponse
      //     .map((e) => OSMdata(
      //         displayname: e['display_name'],
      //         latitude: double.parse(e['lat']),
      //         longitude: double.parse(e['lon'])))
      //     .toList();
      // setState(() {});
    } on Exception catch (e) {
      print('here');
    }
  }


  static getLocationName(double latitude, double longitude) async {
    try {
      String url =
          'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1&accept-language=en';
      var response = await http.post(Uri.parse(url));

      if (response.statusCode == 200) {

        return json.decode(response.body)['display_name'];
        
        // var decodedResponse =
        //     jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;

        // return decodedResponse;
      } else {
        // throw Exception('Failed to get route');
        print('Failed to get route');
      }

      // _options = decodedResponse
      //     .map((e) => OSMdata(
      //         displayname: e['display_name'],
      //         latitude: double.parse(e['lat']),
      //         longitude: double.parse(e['lon'])))
      //     .toList();
      // setState(() {});
    } on Exception catch (e) {
      print('here');
    }
  }

}
