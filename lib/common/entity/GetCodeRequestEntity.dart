// To parse this JSON data, do
//
//     final getCodeRequestEntity = getCodeRequestEntityFromJson(jsonString);

import 'dart:convert';

GetCodeRequestEntity getCodeRequestEntityFromJson(String str) =>
    GetCodeRequestEntity.fromJson(json.decode(str));

String getCodeRequestEntityToJson(GetCodeRequestEntity data) =>
    json.encode(data.toJson());

class GetCodeRequestEntity {
  GetCodeRequestEntity({
    this.phone,
  });
  String phone;

  factory GetCodeRequestEntity.fromJson(Map<String, dynamic> json) =>
      GetCodeRequestEntity(
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
      };
}
