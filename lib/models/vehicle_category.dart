// To parse this JSON data, do
//
//     final vehicleCategory = vehicleCategoryFromJson(jsonString);

import 'dart:convert';

VehicleCategory vehicleCategoryFromJson(String str) =>
    VehicleCategory.fromJson(json.decode(str));

List<VehicleCategory> vehicleCategoriesFromJson(String str) =>
    List<VehicleCategory>.from(json.decode(str).map((x) {
      return VehicleCategory.fromJson(x);
    }));

String vehicleCategoryToJson(VehicleCategory data) =>
    json.encode(data.toJson());

class VehicleCategory {
  int id;
  String name;
  String image;

  VehicleCategory({
    required this.id,
    required this.name,
    required this.image,
  });

  factory VehicleCategory.fromJson(Map<String, dynamic> json) =>
      VehicleCategory(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}

class VehicleCategoryError {
  int code;
  Object message;

  VehicleCategoryError({required this.code, required this.message});
}
