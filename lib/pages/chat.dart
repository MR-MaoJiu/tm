import 'package:flutter/material.dart';
import 'package:tm/common/widgets/widges.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            labelColor: Colors.white,
            tabs: [
              Tab(
                text: "聊天",
              ),
              Tab(
                text: "好友",
              ),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              children: <Widget>[
                FriendCard(
                  nickname: "猫九",
                  gander: "男",
                  photo:
                      "https://wimg.ruan8.com/uploadimg/image/20180912/20180912161716_99988.jpg",
                  body: "哈哈哈",
                  time: "12:36",
                )
              ],
            ),
            ListView(
              children: <Widget>[
                FriendCard(
                  nickname: "猫九",
                  gander: "男",
                  photo:
                      "https://wimg.ruan8.com/uploadimg/image/20180912/20180912161716_99988.jpg",
                  body: "哈哈哈",
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
