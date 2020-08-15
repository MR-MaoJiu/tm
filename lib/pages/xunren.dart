import 'dart:math';
import 'package:amap_location/amap_location.dart';
import 'package:amap_location/amap_location_option.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tm/common/animation/animation.dart';
import 'package:tm/common/api/api.dart';
import 'package:tm/common/entity/UpdateLocRequestEntity.dart';
import 'package:tm/common/entity/UpdateLocResponseEntity.dart';
import 'package:tm/common/utils/play_audio.dart';
import 'package:tm/common/utils/utils.dart';
import 'package:tm/common/entity/entity.dart';
import 'package:tm/common/values/server_address.dart';
import 'package:tm/common/widgets/usercard.dart';

class XunRen extends StatefulWidget {
  @override
  _XunRenState createState() => _XunRenState();
}

class _XunRenState extends State<XunRen> {
  String audioSwitch = "";
  String titletips = "正在寻人";
  int index = 1;
  String latitude;
  String longitude;
  ApiResponse<GetMatchingInformationResponseEntity> entity;
//  ApiResponse<UpdateLocResponseEntity> loc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    FlutterAppBadger.updateBadgeCount(1);
    Global.isPlay == "true" ? audioSwitch = '关闭寻人音效' : audioSwitch = "开启寻人音效";
    debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${Global.isPlay}");
    PlayAudio.isPlay();
    _updateLoc();
  }

  void _updateLoc() async {
//    AMapLocationClient.onLocationUpate.listen((AMapLocation loc) {
//      if (!mounted) return;
//      setState(() {
//        latitude = loc.latitude.toString();
//        longitude = loc.longitude.toString();
//      });
//    });
//
//    AMapLocationClient.startLocation();

    await AMapLocationClient.startup(new AMapLocationOption(
        desiredAccuracy: CLLocationAccuracy.kCLLocationAccuracyHundredMeters));
    AMapLocationClient.getLocation(true).then((value) async {
      latitude = value.latitude.toString() ?? "0";
      longitude = value.longitude.toString() ?? "0";
      await UserAPI.updateLoc(
          params:
              UpdateLocRequestEntity(latitude: latitude, longitude: longitude));
      _getData();
    });
  }

  void _getData() async {
    //获取本机定位，方便查找其它设备
    //TODO:改变定位方式
    await AMapLocationClient.startup(new AMapLocationOption(
        desiredAccuracy: CLLocationAccuracy.kCLLocationAccuracyHundredMeters));
    AMapLocationClient.getLocation(true).then((value) async {
      entity = await UserAPI.getMatchingInformation(
          params: GetMatchingInformationRequestEntity(
              latitude: latitude, longitude: longitude, radius: "100"));
      if (entity.data != null && entity.data.message != null) {
        setState(() {
//        entity.data.userData.length > 0
//            ? titletips = "已搜寻到：${entity.data.userData.length}人"
//            : _getData();
          if (entity.data.userData.length > 0) {
            titletips = "点击重新获取";
            //TODO:弹出卡片
//          entity.data.userData.forEach((element) {
//            showDialog(
//              context: context,
//              // 构建 Dialog 的视图
//              builder: (_) => UsersCard(
//                nickname: element.nickname,
//                src:
//                    "$ipAddress${(element.src ?? "/uploads/videos/home/file_material/20200810/1597058171803bb2678bb2039b.jpg").replaceAll('\\', '/')}",
//                //age: element.age ?? 0,
//                age: element.age ?? 0,
//                gander: element.gander ?? "女",
//                onlinestatus: element.onlinestatus ?? 0,
//                address: element.address ?? "火星",
//                onCloseEvent: () {
//                  Navigator.pop(context);
//                },
//                onPositivePressEvent: () {
//                  debugPrint("===========>");
//                },
//              ),
//            );
//          });

            if (index <= entity.data.userData.length) {
              _showCard(index);
            } else {
              index = 1;
            }
          } else {
            _getData();
          }
        });
      } else {
        Fluttertoast.showToast(
          fontSize: 12.0,
          msg: "网络故障稍后重试",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          textColor: Colors.black87,
          gravity: ToastGravity.BOTTOM,
        );
      }
    });
  }

  _showCard(i) {
    debugPrint("==============================>显示卡片");
    showDialog(
      context: context,
      // 构建 Dialog 的视图
      builder: (_) => UsersCard(
        nickname: entity.data.userData[i - 1].nickname,
        src:
            "$ipAddress${(entity.data.userData[i - 1].src ?? "/admin/img/uhcuwutrrx.jpeg").replaceAll('\\', '/')}",
        //age: element.age ?? 0,
        age: entity.data.userData[i - 1].age ?? 0,
        gander: entity.data.userData[i - 1].gander ?? "女",
        onlinestatus: entity.data.userData[i - 1].onlinestatus ?? 0,
        address: entity.data.userData[i - 1].address ?? "火星",
        onCloseEvent: () {
          Navigator.pop(context);
          if (index < entity.data.userData.length) {
            _showCard(++index);
          } else {
            index = 1;
          }
        },
        onPositivePressEvent: () {
          debugPrint("===========>");
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    PlayAudio.stop();
    AMapLocationClient.shutdown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("寻人"),
      ),
      drawer: Drawer(
        //侧边栏按钮Drawer
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              //Material内置控件
              accountName: Text('猫九先森'), //用户名
              accountEmail: Text('481869314@qq.com'), //用户邮箱
              currentAccountPicture: GestureDetector(
                //TODO:修改头像
                //用户头像
                onTap: () => print('current user'),
                child: CircleAvatar(
                  //圆形图标控件
                  backgroundImage: NetworkImage(
                      'https://upload.jianshu.io/users/upload_avatars/7700793/dbcf94ba-9e63-4fcf-aa77-361644dd5a87?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240'), //图片调取自网络
                ),
              ),
              decoration: BoxDecoration(
                //用一个BoxDecoration装饰器提供背景图片
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        'https://upload.jianshu.io/users/upload_avatars/8346438/e3e45f12-b3c2-45a1-95ac-a608fa3b8960?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240')
                    //可以试试图片调取自本地。调用本地资源，需要到pubspec.yaml中配置文件路径
//                  image: ExactAssetImage('images/tm.png'),
                    ),
              ),
            ),
            ListTile(
                //第一个功能项
                title: Text(audioSwitch),
                leading: Icon(Global.isPlay == "true"
                    ? Icons.volume_off
                    : Icons.volume_up),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  debugPrint("${Global.isPlay}");
                  Navigator.of(context).pop();
                  Global.isPlay == "true"
                      ? SpUtil().setString('audio', "false")
                      : SpUtil().setString('audio', "true");
                  setState(() {
                    Global.isPlay = SpUtil().getString('audio');
                    Global.isPlay == "true"
                        ? audioSwitch = '关闭寻人音效'
                        : audioSwitch = "开启寻人音效";
                    PlayAudio.isPlay();
                  });
                }),
            ListTile(
                //第一个功能项
                title: Text('编辑资料'),
                leading: Icon(Icons.credit_card),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  Navigator.of(context).pop();
//                  Navigator.of(context).push(MaterialPageRoute(
//                      builder: (BuildContext context) => AnimBgDemoPage()));
                }),
            ListTile(
                //第二个功能项
                title: Text('消息提醒'),
                leading: Icon(Icons.notifications_active),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  Navigator.of(context).pop();
//                    Navigator.of(context).push( MaterialPageRoute(builder: (BuildContext context) =>  SidebarPage()));
                }),
            ListTile(
                //第二个功能项
                title: Text('清除缓存'),
                leading: Icon(Icons.delete),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  Navigator.of(context).pop();
//                    Navigator.of(context).push( MaterialPageRoute(builder: (BuildContext context) =>  SidebarPage()));
                }),
            ListTile(
              //退出按钮
              title: Text('关于TM'),
              leading: Icon(Icons.dashboard),
              trailing: Icon(Icons.navigate_next),
              onTap: () => Navigator.of(context).pop(), //点击后收起侧边栏
            ),
            ListTile(
                //第二个功能项
                title: Text('用户协议'),
                leading: Icon(Icons.library_books),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  Navigator.of(context).pop();
//                    Navigator.of(context).push( MaterialPageRoute(builder: (BuildContext context) =>  SidebarPage()));
                }),
            Divider(), //
            ListTile(
                //第二个功能项
                title: Text('注销账号'),
                leading: Icon(Icons.power_settings_new),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  Navigator.of(context).pop();
//                    Navigator.of(context).push( MaterialPageRoute(builder: (BuildContext context) =>  SidebarPage()));
                }),
            ListTile(
                //第二个功能项
                title: Text('退出登录'),
                leading: Icon(Icons.exit_to_app),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  Navigator.of(context).pop();
//                    Navigator.of(context).push( MaterialPageRoute(builder: (BuildContext context) =>  SidebarPage()));
                }),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(child: AnimatedBackground()),
          onBottom(AnimatedWave(
            height: 180,
            speed: 1.0,
          )),
          onBottom(AnimatedWave(
            height: 120,
            speed: 0.9,
            offset: pi,
          )),
          onBottom(AnimatedWave(
            height: 220,
            speed: 1.2,
            offset: pi / 2,
          )),
          Positioned.fill(
              child: Center(
            child: FlatButton(
              onPressed: () {
                setState(() {
                  titletips = "正在寻人";
                  _updateLoc();
                });
              },
              child: Text(
                titletips,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          )),
        ],
      ),
    );
  }

  onBottom(Widget child) => Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      );
}
