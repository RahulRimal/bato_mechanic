// To parse this JSON data, do
//
//     final mechanic = mechanicFromJson(jsonString);

import 'dart:convert';

Mechanic mechanicFromJson(String str) => Mechanic.fromJson(json.decode(str));

List<Mechanic> mechanicsFromJson(String str) =>
    List<Mechanic>.from(json.decode(str).map((x) {
      return Mechanic.fromJson(x);
    }));

String mechanicToJson(Mechanic data) => json.encode(data.toJson());

class Mechanic {
  int id;
  int userId;
  String firstName;
  String lastName;
  String phoneNumber;
  String username;
  String email;
  String description;
  String image;
  String vehicleSpeciality;
  String vehiclePartSpeciality;
  double averageRating;

  Mechanic({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.username,
    required this.email,
    required this.description,
    required this.image,
    required this.vehicleSpeciality,
    required this.vehiclePartSpeciality,
    required this.averageRating,
  });

  factory Mechanic.fromJson(Map<String, dynamic> json) => Mechanic(
        id: json["id"],
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        username: json["username"],
        email: json["email"],
        description: json["description"],
        image: json["image"],
        vehicleSpeciality: json["vehicle_speciality"],
        vehiclePartSpeciality: json["vehicle_part_speciality"],
        averageRating: double.parse(json["average_rating"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "username": username,
        "email": email,
        "description": description,
        "image": image,
        "vehicle_speciality": vehicleSpeciality,
        "vehicle_part_speciality": vehiclePartSpeciality,
        "average_rating": averageRating,
      };
}

class MechanicError {
  int code;
  Object message;

  MechanicError({required this.code, required this.message});
}
