import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tm/common/entity/LoginResponseEntity.dart';
import 'package:tm/common/utils/utils.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;
  bool _isLogined = false;
//  startTime() async {
//    //设置启动图生效时间
//    var _duration = new Duration(seconds: 3);
//    return new Timer(_duration, navigationPage);
//  }

  initState() {
    super.initState();
    // startTime();
    _controller = new AnimationController(
        duration: const Duration(seconds: 2), vsync: this);
    //图片宽高从0变到300
    _animation = new Tween(begin: 1.0, end: 200.00).animate(_controller)
      ..addListener(() {
        setState(() => {
              if (_animation.value == 200.00) {navigationPage()}
            });
      });
    //启动动画(正向执行)
    _controller.forward();
  }

  void navigationPage() {
    var _json = SpUtil().getJSON("accessToken") ?? "";
    Global.isPlay = SpUtil().getString('audio') ?? "";
    String _token;
    _json == ""
        ? _token = ""
        : _token = LoginResponseEntity.fromJson(_json).token;
    Global.accessToken = _token;
    _token.isEmpty ? _isLogined = false : _isLogined = true;
    //判断token是存在如果不存在跳转到登录页面，如果存在就跳转到主页面。
    if (_isLogined) {
      Navigator.of(context).pushReplacementNamed('/bottom_navigation');
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  void dispose() {
    //路由销毁时需要释放动画资源
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 281.25, height: 609, allowFontScaling: true);
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg_sp.png"), fit: BoxFit.fill)),
      child: Container(
          margin: EdgeInsets.fromLTRB(110.75, 136.75, 110.75, 412.5),
          child: Center(
            child: Image.asset(
              "assets/images/tm.png",
              width: duSetWidth(_animation.value),
            ),
          )),
    );
  }
}
