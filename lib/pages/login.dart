import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_ip/get_ip.dart';
import 'package:tm/common/api/api.dart';
import 'package:tm/common/entity/LoginRequestEntity.dart';
import 'package:tm/common/entity/LoginResponseEntity.dart';
import 'package:tm/common/utils/utils.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  //获取Key用来获取Form表单组件
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  String userName;
  String password;
  bool isShowPassWord = false;
  String ip;
  Future login() async {
    userName = _phoneController.text;
    password = _passwordController.text;

    if (userName.isNotEmpty && password.isNotEmpty) {
      print('userName: ' + userName + ' password: ' + password + 'ip' + ip);

      //提交登陆表单
      ApiResponse<LoginResponseEntity> entity = await UserAPI.login(
          params: LoginRequestEntity(
              phone: userName, password: password, ip: "127.0.0.1"));
      var value = entity.data;
      if (value.code == 1) {
        //如果账号密码正确则保存Token及登录状态
        SpUtil().setJSON("accessToken", entity.data);
        Global.accessToken = entity.data.token;
        Navigator.of(context).pushNamedAndRemoveUntil(
            "/bottom_navigation", (Route<dynamic> route) => false);
      } else {
        Fluttertoast.showToast(
          fontSize: 12.0,
          msg: value.msg,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          textColor: Colors.black87,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } else {
      Fluttertoast.showToast(
        fontSize: 12.0,
        msg: "账号或密码不能为空",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        textColor: Colors.black87,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  Future<void> getIP() async {
    ip = await GetIp.ipAddress;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIP();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: 100.0, bottom: 10.0),
                child: Text(
                  '登录TM',
                  style: TextStyle(fontSize: 50.0),
                )),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1.0))),
                    child: TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: '请输入手机号',
                        labelStyle: TextStyle(
                          fontSize: 15.0,
                        ),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.close,
                          ),
                          onPressed: () {
                            _phoneController.text = "";
                          },
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1.0))),
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          labelText: '请输入密码',
                          labelStyle: TextStyle(
                            fontSize: 15.0,
                          ),
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: Icon(
                              isShowPassWord
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: showPassWord,
                          )),
                      obscureText: !isShowPassWord,
                    ),
                  ),
                  Container(
                    height: 45.0,
                    margin: EdgeInsets.only(top: 40.0),
                    child: SizedBox.expand(
                      child: RaisedButton(
                        onPressed: login,
                        child: Text(
                          '登录',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(45.0)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30.0),
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            child: FlatButton(
                          child: Text(
                            '注册账号',
                            style: TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/registered',
                                arguments: {'title': '注册账号', 'button': '注册'});
                          },
                        )),
                        FlatButton(
                          child: Text(
                            '找回密码',
                            style: TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/registered',
                                arguments: {'title': '找回密码', 'button': '找回'});
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
