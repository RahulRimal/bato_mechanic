// To parse this JSON data, do
//
//     final vehiclePart = vehiclePartFromJson(jsonString);

import 'dart:convert';

VehiclePart vehiclePartFromJson(String str) =>
    VehiclePart.fromJson(json.decode(str));

List<VehiclePart> vehiclePartsFromJson(String str) =>
    List<VehiclePart>.from(json.decode(str).map((x) {
      return VehiclePart.fromJson(x);
    }));

String vehiclePartToJson(VehiclePart data) => json.encode(data.toJson());

class VehiclePart {
  int id;
  String name;
  int vehicleId;
  String image;

  VehiclePart({
    required this.id,
    required this.name,
    required this.vehicleId,
    required this.image,
  });

  factory VehiclePart.fromJson(Map<String, dynamic> json) => VehiclePart(
        id: json["id"],
        name: json["name"],
        vehicleId: json["vehicle"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "vehicle": vehicleId,
        "image": image,
      };
}

class VehiclePartError {
  int code;
  Object message;

  VehiclePartError({required this.code, required this.message});
}
