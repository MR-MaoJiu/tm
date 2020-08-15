import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tm/common/api/api.dart';
import 'package:tm/common/entity/GetCodeRequestEntity.dart';
import 'package:tm/common/entity/GetCodeResponseEntity.dart';
import 'package:tm/common/entity/RegisteredRequestEntity.dart';
import 'package:tm/common/entity/RegisteredResponseEntity.dart';
import 'package:tm/common/utils/utils.dart';

class Registered extends StatefulWidget {
  @override
  _Registered createState() => _Registered();
}

class _Registered extends State<Registered> {
  TextEditingController _phoneEditingController = TextEditingController();
  TextEditingController _verificationEditingController =
      TextEditingController();
  //获取Key用来获取Form表单组件
  GlobalKey<FormState> RegisteredKey = GlobalKey<FormState>();
  String userName;
  String password;
  String verification;
  bool isShowPassWord = false;
  Timer _timer;
  int _countdownTime = 0;
  String tips;
  Map args;
  //发送验证码
  _getCode() async {
    //Http请求发送验证码
    ApiResponse<GetCodeResponseEntity> entity = await UserAPI.getCode(
        params: GetCodeRequestEntity(phone: _phoneEditingController.text));
    Fluttertoast.showToast(
      fontSize: 12.0,
      msg: entity.data.msg,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      textColor: Colors.black87,
      gravity: ToastGravity.BOTTOM,
    );
  }

//倒计时
  void startCountdownTimer() {
    debugPrint('开始倒计时==============================>');
    const oneSec = const Duration(seconds: 1);

    var callback = (timer) => {
          setState(() {
            if (_countdownTime < 1) {
              _timer.cancel();
            } else {
              _countdownTime = _countdownTime - 1;
            }
          })
        };

    _timer = Timer.periodic(oneSec, callback);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> Registered() async {
    //读取当前的Form状态
    var RegisteredForm = RegisteredKey.currentState;
    //验证Form表单
    if (RegisteredForm.validate()) {
      RegisteredForm.save();
      print('userName: ' +
          userName +
          ' password: ' +
          password +
          ' verification ' +
          verification);
      if (userName.length != 11) {
        tips = "手机号不正确";
      } else if (password.length < 6) {
        tips = "密码不能小于6位";
      } else {}
      if (args['title'] == "注册账号") {
        ApiResponse<RegisteredResponseEntity> entity = await UserAPI.regist(
            params: RegisteredRequestEntity(
                phone: userName,
                password: password,
                mobile_code: verification));
        tips = "${entity.data.msg}";
      } else {}
      Fluttertoast.showToast(
        fontSize: 12.0,
        msg: "$tips",
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

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 100.0, bottom: 10.0),
              child: Text(
                args['title'],
                style: TextStyle(fontSize: 50.0),
              )),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: RegisteredKey,
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1.0))),
                    child: TextFormField(
                      controller: _phoneEditingController,
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
                            _phoneEditingController.text = "";
                          },
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      onSaved: (value) {
                        userName = value;
                      },
                      validator: (phone) {
                        // if(phone.length == 0){
                        //   return '请输入手机号';
                        // }
                      },
                      onFieldSubmitted: (value) {},
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1.0))),
                    child: TextFormField(
                      controller: _verificationEditingController,
                      decoration: InputDecoration(
                        labelText: '请输入验证码',
                        labelStyle: TextStyle(
                          fontSize: 15.0,
                        ),
                        border: InputBorder.none,
                        suffixIcon: FlatButton(
                          child: Text(
                            _countdownTime > 0
                                ? '$_countdownTime后重新获取'
                                : '获取验证码',
                          ),
                          onPressed: () {
                            if (_phoneEditingController.text
                                .toString()
                                .isEmpty) {
                              Fluttertoast.showToast(
                                fontSize: 12.0,
                                msg: "手机号不能为空",
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                textColor: Colors.black87,
                                gravity: ToastGravity.BOTTOM,
                              );
                            } else {
                              if (_countdownTime == 0) {
                                //开始倒计时
                                startCountdownTimer();
                                setState(() {
                                  _countdownTime = 60;
                                });
                                _getCode();
                              }
                            }
                          },
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      onSaved: (value) {
                        verification = value;
                      },
                      validator: (phone) {
                        // if(phone.length == 0){
                        //   return '请输入手机号';
                        // }
                      },
                      onFieldSubmitted: (value) {},
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1.0))),
                    child: TextFormField(
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
                      onSaved: (value) {
                        password = value;
                      },
                    ),
                  ),
                  Container(
                    height: 45.0,
                    margin: EdgeInsets.only(top: 40.0),
                    child: SizedBox.expand(
                      child: RaisedButton(
                        onPressed: Registered,
                        child: Text(
                          args['button'],
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(45.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }
}
