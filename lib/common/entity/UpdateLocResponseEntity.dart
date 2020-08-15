// To parse this JSON data, do
//
//     final updateLocResponseEntity = updateLocResponseEntityFromJson(jsonString);

import 'dart:convert';

UpdateLocResponseEntity updateLocResponseEntityFromJson(String str) =>
    UpdateLocResponseEntity.fromJson(json.decode(str));

String updateLocResponseEntityToJson(UpdateLocResponseEntity data) =>
    json.encode(data.toJson());

class UpdateLocResponseEntity {
  UpdateLocResponseEntity({
    this.code,
    this.msg,
  });

  int code;
  String msg;

  factory UpdateLocResponseEntity.fromJson(Map<String, dynamic> json) =>
      UpdateLocResponseEntity(
        code: json["code"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
      };
}
