// To parse this JSON data, do
//
//     final getPostResponseEntity = getPostResponseEntityFromJson(jsonString);

import 'dart:convert';

GetPostResponseEntity getPostResponseEntityFromJson(String str) =>
    GetPostResponseEntity.fromJson(json.decode(str));

String getPostResponseEntityToJson(GetPostResponseEntity data) =>
    json.encode(data.toJson());

class GetPostResponseEntity {
  GetPostResponseEntity({
    this.code,
    this.message,
    this.postData,
    this.postUserData,
  });

  int code;
  String message;
  List<PostDatum> postData;
  List<PostUserDatum> postUserData;

  factory GetPostResponseEntity.fromJson(Map<String, dynamic> json) =>
      GetPostResponseEntity(
        code: json["code"],
        message: json["message"],
        postData: List<PostDatum>.from(
            json["postData"].map((x) => PostDatum.fromJson(x))),
        postUserData: List<PostUserDatum>.from(
            json["PostUserData"].map((x) => PostUserDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "postData": List<dynamic>.from(postData.map((x) => x.toJson())),
        "PostUserData": List<dynamic>.from(postUserData.map((x) => x.toJson())),
      };
}

class PostDatum {
  PostDatum({
    this.body,
    this.likenum,
    this.createTime,
    this.src,
    this.type,
    this.uid,
  });

  String body;
  int likenum;
  int createTime;
  String src;
  int type;
  int uid;

  factory PostDatum.fromJson(Map<String, dynamic> json) => PostDatum(
        body: json["body"],
        likenum: json["likenum"],
        createTime: json["create_time"],
        src: json["src"],
        type: json["type"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "body": body,
        "likenum": likenum,
        "create_time": createTime,
        "src": src,
        "type": type,
        "uid": uid,
      };
}

class PostUserDatum {
  PostUserDatum({
    this.nickname,
    this.age,
    this.gander,
    this.src,
  });

  String nickname;
  int age;
  String gander;
  dynamic src;

  factory PostUserDatum.fromJson(Map<String, dynamic> json) => PostUserDatum(
        nickname: json["nickname"],
        age: json["age"],
        gander: json["gander"],
        src: json["src"],
      );

  Map<String, dynamic> toJson() => {
        "nickname": nickname,
        "age": age,
        "gander": gander,
        "src": src,
      };
}
