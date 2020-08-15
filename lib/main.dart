import 'package:amap_location/amap_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tm/common/utils/utils.dart';
import 'package:tm/pages/bottom_navigation.dart';
import 'package:tm/pages/registered.dart';
import 'package:tm/pages/welcome.dart';
import 'common/values/values.dart';
import 'pages/login.dart';

void main() {
  HttpUtils.init(
    ///接口基地址
    baseUrl: ipAddress,
  );
  AMapLocationClient.setApiKey("a9af2a506b91660f6decc0455b90277c");
  //_initJPush();
  WidgetsFlutterBinding.ensureInitialized();
  SpUtil.init()..then((e) => runApp(MyApp()));
}
//
//void _initJPush() async {
//  await FlutterJPush.startup();
//  print("初始化jpush成功");
//
//  // 获取 registrationID
//  var registrationID = await FlutterJPush.getRegistrationID();
//  print(registrationID);
//
//  // 注册接收和打开 Notification()
//  _initNotification();
//}
//
//void _initNotification() async {
//  FlutterJPush.addReceiveNotificationListener((JPushNotification notification) {
//    print("收到推送提醒: $notification");
//  });
//
//  FlutterJPush.addReceiveOpenNotificationListener(
//      (JPushNotification notification) {
//    print("打开了推送提醒: $notification");
//  });
//}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/login': (_) => Login(),
        '/registered': (_) => Registered(),
        '/bottom_navigation': (_) => BottomNavigation(),
      },
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false, //去掉debug
      title: 'TM',
      theme: ThemeData(
        primaryColor: Colors.cyan,
        bottomAppBarColor: Colors.cyan,
        buttonColor: Colors.cyan,
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.cyan),
      ),
      home: WelcomePage(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('zh', 'CH'),
      ],
    );
  }
}
