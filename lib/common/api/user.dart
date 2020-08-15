import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:tm/common/entity/UpdateLocRequestEntity.dart';
import 'package:tm/common/entity/UpdateLocResponseEntity.dart';
import 'package:tm/common/entity/entity.dart';
import 'package:tm/common/utils/utils.dart';
import 'package:tm/common/values/values.dart';

/// 用户
class UserAPI {
  /// 登录
  static Future<ApiResponse<LoginResponseEntity>> login(
      {LoginRequestEntity params}) async {
    try {
      var response = await HttpUtils.post(loginAddress, data: params.toJson());
      debugPrint("返回消息：$response");
      return ApiResponse.completed(LoginResponseEntity.fromJson(response));
    } on DioError catch (e) {
      return ApiResponse.error(e.error);
    }
  }

  ///注册
  static Future<ApiResponse<RegisteredResponseEntity>> regist(
      {RegisteredRequestEntity params}) async {
    try {
      var response =
          await HttpUtils.post(registeredAddress, data: params.toJson());
      debugPrint("返回消息：$response");
      return ApiResponse.completed(RegisteredResponseEntity.fromJson(response));
    } on DioError catch (e) {
      return ApiResponse.error(e.error);
    }
  }

  ///获取用户
  static Future<ApiResponse<GetMatchingInformationResponseEntity>>
      getMatchingInformation(
          {GetMatchingInformationRequestEntity params}) async {
    try {
      var response =
          await HttpUtils.post(getUserAddress, data: params.toJson());
      debugPrint("返回消息：$response");
      return ApiResponse.completed(
          GetMatchingInformationResponseEntity.fromJson(response));
    } on DioError catch (e) {
      return ApiResponse.error(e.error);
    }
  }

  ///更新用户位置
  static Future<ApiResponse<UpdateLocResponseEntity>> updateLoc(
      {UpdateLocRequestEntity params}) async {
    try {
      var response =
          await HttpUtils.post(getUserAddress, data: params.toJson());
      debugPrint("返回消息：$response");
      return ApiResponse.completed(UpdateLocResponseEntity.fromJson(response));
    } on DioError catch (e) {
      return ApiResponse.error(e.error);
    }
  }

  ///获取验证码
  static Future<ApiResponse<GetCodeResponseEntity>> getCode(
      {GetCodeRequestEntity params}) async {
    try {
      var response =
          await HttpUtils.post(getCodeAddress, data: params.toJson());
      debugPrint("返回消息：$response");
      return ApiResponse.completed(GetCodeResponseEntity.fromJson(response));
    } on DioError catch (e) {
      return ApiResponse.error(e.error);
    }
  }
}
