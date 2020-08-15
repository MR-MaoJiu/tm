// To parse this JSON data, do
//
//     final loginResponseEntity = loginResponseEntityFromJson(jsonString);

import 'dart:convert';

LoginResponseEntity loginResponseEntityFromJson(String str) =>
    LoginResponseEntity.fromJson(json.decode(str));

String loginResponseEntityToJson(LoginResponseEntity data) =>
    json.encode(data.toJson());

class LoginResponseEntity {
  LoginResponseEntity({
    this.code,
    this.msg,
    this.token,
  });

  int code;
  String msg;
  String token;

  factory LoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      LoginResponseEntity(
        code: json["code"],
        msg: json["msg"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "token": token,
      };
}
