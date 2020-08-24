import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tm/common/utils/play_audio.dart';
import 'package:tm/pages/xunren.dart';
import 'package:tm/pages/chat.dart';
import 'package:tm/pages/dongtai.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final pages = [XunRen(), DongTai(), Chat()];
  var currentIndex = 0;
  DateTime lastPopTime;
  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.wifi_tethering),
      title: Text("寻人"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.language),
      title: Text("动态"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.message),
      title: Text("聊天"),
    ),
  ];
  /*切换页面*/
  void _changePage(int index) {
    /*如果点击的导航项不是当前项  切换 */
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: bottomNavItems,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            _changePage(index);
          },
        ),
        body: pages[currentIndex],
      ),
      // ignore: missing_return
      onWillPop: () async {
        // 点击返回键的操作
        if (lastPopTime == null ||
            DateTime.now().difference(lastPopTime) > Duration(seconds: 2)) {
          lastPopTime = DateTime.now();
          Fluttertoast.showToast(
            fontSize: 12.0,
            msg: "再按一次退出",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            textColor: Colors.black87,
            gravity: ToastGravity.BOTTOM,
          );
        } else {
          lastPopTime = DateTime.now();
          PlayAudio.stop();
          // 退出app
          await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }
      },
    );
  }
}
