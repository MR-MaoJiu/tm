// To parse this JSON data, do
//
//     final getMatchingInformationResponseEntity = getMatchingInformationResponseEntityFromJson(jsonString);

import 'dart:convert';

GetMatchingInformationResponseEntity
    getMatchingInformationResponseEntityFromJson(String str) =>
        GetMatchingInformationResponseEntity.fromJson(json.decode(str));

String getMatchingInformationResponseEntityToJson(
        GetMatchingInformationResponseEntity data) =>
    json.encode(data.toJson());

class GetMatchingInformationResponseEntity {
  GetMatchingInformationResponseEntity({
    this.code,
    this.message,
    this.userData,
  });

  int code;
  String message;
  List<UserDatum> userData;

  factory GetMatchingInformationResponseEntity.fromJson(
          Map<String, dynamic> json) =>
      GetMatchingInformationResponseEntity(
        code: json["code"],
        message: json["message"],
        userData: List<UserDatum>.from(
            json["userData"].map((x) => UserDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "userData": List<dynamic>.from(userData.map((x) => x.toJson())),
      };
}

class UserDatum {
  UserDatum({
    this.nickname,
    this.gander,
    this.age,
    this.onlinestatus,
    this.likenum,
    this.signature,
    this.address,
    this.src,
  });

  String nickname;
  String gander;
  int age;
  int onlinestatus;
  int likenum;
  String signature;
  String address;
  String src;

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
        nickname: json["nickname"],
        gander: json["gander"],
        age: json["age"],
        onlinestatus: json["onlinestatus"],
        likenum: json["likenum"],
        signature: json["signature"],
        address: json["address"],
        src: json["src"],
      );

  Map<String, dynamic> toJson() => {
        "nickname": nickname,
        "gander": gander,
        "age": age,
        "onlinestatus": onlinestatus,
        "likenum": likenum,
        "signature": signature,
        "address": address,
        "src": src,
      };
}
