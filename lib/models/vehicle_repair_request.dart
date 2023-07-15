// To parse this JSON data, do
//
//     final vehicleRepairRequest = vehicleRepairRequestFromJson(jsonString);

import 'dart:convert';

VehicleRepairRequest vehicleRepairRequestFromJson(String str) =>
    VehicleRepairRequest.fromJson(json.decode(str));

List<VehicleRepairRequest> vehicleRepairRequestsFromJson(String str) =>
    List<VehicleRepairRequest>.from(json.decode(str).map((x) {
      return VehicleRepairRequest.fromJson(x);
    }));

String vehicleRepairRequestToJson(VehicleRepairRequest data) =>
    json.encode(data.toJson());

class VehicleRepairRequest {
  int id;
  int customerId;
  int preferredMechanicId;
  String locationName;
  String locationCoordinates;
  int vehicleId;
  int vehiclePartId;
  String description;
  List<VehicleRepairRequestImage> images;
  List<VehicleRepairRequestVideo> videos;
  DateTime createdAt;

  VehicleRepairRequest({
    required this.id,
    required this.customerId,
    required this.preferredMechanicId,
    required this.locationName,
    required this.locationCoordinates,
    required this.vehicleId,
    required this.vehiclePartId,
    required this.description,
    required this.images,
    required this.videos,
    required this.createdAt,
  });

  factory VehicleRepairRequest.fromJson(Map<String, dynamic> json) =>
      VehicleRepairRequest(
        id: json["id"],
        customerId: json["customer"],
        preferredMechanicId: json["preferred_mechanic"],
        locationName: json["location_name"],
        locationCoordinates: json["location_coordinates"],
        vehicleId: json["vehicle"],
        vehiclePartId: json["vehicle_part"],
        description: json["description"],
        images: List<VehicleRepairRequestImage>.from(
            json["images"].map((x) => VehicleRepairRequestImage.fromJson(x))),
        videos: List<VehicleRepairRequestVideo>.from(
            json["videos"].map((x) => VehicleRepairRequestVideo.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer": customerId,
        "preferred_mechanic": preferredMechanicId,
        "location_name": locationName,
        "location_coordinates": locationCoordinates,
        "vehicle": vehicleId,
        "vehicle_part": vehiclePartId,
        "description": description,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
      };
}

class VehicleRepairRequestImage {
  int id;
  String image;

  VehicleRepairRequestImage({
    required this.id,
    required this.image,
  });

  factory VehicleRepairRequestImage.fromJson(Map<String, dynamic> json) =>
      VehicleRepairRequestImage(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}

class VehicleRepairRequestVideo {
  int id;
  String video;

  VehicleRepairRequestVideo({
    required this.id,
    required this.video,
  });

  factory VehicleRepairRequestVideo.fromJson(Map<String, dynamic> json) =>
      VehicleRepairRequestVideo(
        id: json["id"],
        video: json["video"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "video": video,
      };
}

class VehicleRepairRequestError {
  int code;
  Object message;

  VehicleRepairRequestError({required this.code, required this.message});
}
