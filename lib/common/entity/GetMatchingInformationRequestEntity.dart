// To parse this JSON data, do
//
//     final getMatchingInformationRequestEntity = getMatchingInformationRequestEntityFromJson(jsonString);

import 'dart:convert';

GetMatchingInformationRequestEntity getMatchingInformationRequestEntityFromJson(
        String str) =>
    GetMatchingInformationRequestEntity.fromJson(json.decode(str));

String getMatchingInformationRequestEntityToJson(
        GetMatchingInformationRequestEntity data) =>
    json.encode(data.toJson());

class GetMatchingInformationRequestEntity {
  GetMatchingInformationRequestEntity({
    this.latitude,
    this.longitude,
    this.radius,
  });

  String latitude;
  String longitude;
  String radius;

  factory GetMatchingInformationRequestEntity.fromJson(
          Map<String, dynamic> json) =>
      GetMatchingInformationRequestEntity(
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
