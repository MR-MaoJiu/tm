import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/screenutil.dart';


/// 设置宽度
double duSetWidth(double width) {
  debugPrint("$width");
  return ScreenUtil().setWidth(width);
}

/// 设置宽度
double duSetHeight(double height) {
  return ScreenUtil().setHeight(height);
}

/// 设置字体尺寸
double duSetFontSize(double fontSize) {
  return ScreenUtil().setSp(fontSize);
}
