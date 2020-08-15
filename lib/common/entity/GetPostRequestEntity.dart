// To parse this JSON data, do
//
//     final getPostRequestEntity = getPostRequestEntityFromJson(jsonString);

import 'dart:convert';

GetPostRequestEntity getPostRequestEntityFromJson(String str) =>
    GetPostRequestEntity.fromJson(json.decode(str));

String getPostRequestEntityToJson(GetPostRequestEntity data) =>
    json.encode(data.toJson());

class GetPostRequestEntity {
  GetPostRequestEntity({
    this.latitude,
    this.longitude,
    this.radius,
  });

  String latitude;
  String longitude;
  String radius;

  factory GetPostRequestEntity.fromJson(Map<String, dynamic> json) =>
      GetPostRequestEntity(
        latitude: json["latitude"],
        longitude: json["longitude"],
        radius: json["radius"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "radius": radius,
      };
}
