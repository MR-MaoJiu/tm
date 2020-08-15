// To parse this JSON data, do
//
//     final registeredResponseEntity = registeredResponseEntityFromJson(jsonString);

import 'dart:convert';

RegisteredResponseEntity registeredResponseEntityFromJson(String str) =>
    RegisteredResponseEntity.fromJson(json.decode(str));

String registeredResponseEntityToJson(RegisteredResponseEntity data) =>
    json.encode(data.toJson());

class RegisteredResponseEntity {
  RegisteredResponseEntity({
    this.code,
    this.msg,
  });

  int code;
  String msg;

  factory RegisteredResponseEntity.fromJson(Map<String, dynamic> json) =>
      RegisteredResponseEntity(
        code: json["code"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
      };
}
