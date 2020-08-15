// To parse this JSON data, do
//
//     final getCodeResponseEntity = getCodeResponseEntityFromJson(jsonString);

import 'dart:convert';

GetCodeResponseEntity getCodeResponseEntityFromJson(String str) =>
    GetCodeResponseEntity.fromJson(json.decode(str));

String getCodeResponseEntityToJson(GetCodeResponseEntity data) =>
    json.encode(data.toJson());

class GetCodeResponseEntity {
  GetCodeResponseEntity({
    this.code,
    this.msg,
  });

  int code;
  String verification;
  String msg;

  factory GetCodeResponseEntity.fromJson(Map<String, dynamic> json) =>
      GetCodeResponseEntity(
        code: json["code"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
      };
}
