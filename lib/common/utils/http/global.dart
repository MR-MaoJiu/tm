import 'package:flutter/cupertino.dart';

/// 全局配置
class Global {
  /// token
  static String accessToken = "";
//  static int character = 5;
  static bool retryEnable = true;
  static String isPlay = "true";

  ///解决上下文改变弹框报错
  GlobalKey _scaffoldKey;
  Global() {
    _scaffoldKey = GlobalKey();
  }
  GlobalKey get scaffoldKey => _scaffoldKey;

  /// 是否 release
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");
}
