// To parse this JSON data, do
//
//     final updateLocRequestEntity = updateLocRequestEntityFromJson(jsonString);

import 'dart:convert';

UpdateLocRequestEntity updateLocRequestEntityFromJson(String str) =>
    UpdateLocRequestEntity.fromJson(json.decode(str));

String updateLocRequestEntityToJson(UpdateLocRequestEntity data) =>
    json.encode(data.toJson());

class UpdateLocRequestEntity {
  UpdateLocRequestEntity({
    this.latitude,
    this.longitude,
  });

  String latitude;
  String longitude;

  factory UpdateLocRequestEntity.fromJson(Map<String, dynamic> json) =>
      UpdateLocRequestEntity(
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
