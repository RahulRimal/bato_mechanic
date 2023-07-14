// class Vehicle {
//   Vehicle(
//       {required this.name,
//       required this.image,
//       required this.type,
//       required this.tagLine});

//   String image;
//   String name;
//   String type;
//   String tagLine;
// }

// To parse this JSON data, do
//
//     final vehicle = vehicleFromJson(jsonString);

import 'dart:convert';

Vehicle vehicleFromJson(String str) => Vehicle.fromJson(json.decode(str));

List<Vehicle> vehiclesFromJson(String str) =>
    List<Vehicle>.from(json.decode(str).map((x) {
      return Vehicle.fromJson(x);
    }));

String vehicleToJson(Vehicle data) => json.encode(data.toJson());

class Vehicle {
  int id;
  String name;
  int category;
  String image;

  Vehicle({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "image": image,
      };
}

class VehicleError {
  int code;
  Object message;

  VehicleError({required this.code, required this.message});
}
