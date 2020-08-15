// To parse this JSON data, do
//
//     final loginRequestEntity = loginRequestEntityFromJson(jsonString);

import 'dart:convert';

LoginRequestEntity loginRequestEntityFromJson(String str) =>
    LoginRequestEntity.fromJson(json.decode(str));

String loginRequestEntityToJson(LoginRequestEntity data) =>
    json.encode(data.toJson());

class LoginRequestEntity {
  LoginRequestEntity({
    this.phone,
    this.password,
    this.ip,
  });

  String phone;
  String password;
  String ip;

  factory LoginRequestEntity.fromJson(Map<String, dynamic> json) =>
      LoginRequestEntity(
        phone: json["phone"],
        password: json["password"],
        ip: json["ip"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "password": password,
        "ip": ip,
      };
}
