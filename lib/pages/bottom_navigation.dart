import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tm/common/utils/play_audio.dart';
import 'package:tm/pages/xunren.dart';
import 'package:tm/common/utils/utils.dart';
import 'package:tm/pages/chat.dart';
import 'package:tm/pages/dongtai.dart';
import 'package:tm/pages/test.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final pages = [XunRen(), DongTai(), Chat()];
  var currentIndex = 0;

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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          _changePage(index);
        },
      ),
      body: pages[currentIndex],
    );
  }
}
