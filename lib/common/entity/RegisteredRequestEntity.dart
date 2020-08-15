// To parse this JSON data, do
//
//     final registeredRequestEntity = registeredRequestEntityFromJson(jsonString);

import 'dart:convert';

RegisteredRequestEntity registeredRequestEntityFromJson(String str) =>
    RegisteredRequestEntity.fromJson(json.decode(str));

String registeredRequestEntityToJson(RegisteredRequestEntity data) =>
    json.encode(data.toJson());

class RegisteredRequestEntity {
  RegisteredRequestEntity({
    this.phone,
    this.mobile_code,
    this.password,
  });

  String phone;
  String mobile_code;
  String password;

  factory RegisteredRequestEntity.fromJson(Map<String, dynamic> json) =>
      RegisteredRequestEntity(
        phone: json["phone"],
        mobile_code: json["mobile_code"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "mobile_code": mobile_code,
        "password": password,
      };
}
