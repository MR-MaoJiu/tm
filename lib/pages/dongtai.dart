import 'package:flutter/material.dart';
import 'package:tm/common/values/values.dart';
import 'package:tm/common/widgets/posts_card.dart';
import 'package:tm/common/widgets/widges.dart';

class DongTai extends StatefulWidget {
  @override
  _DongTaiState createState() => _DongTaiState();
}

class _DongTaiState extends State<DongTai> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, "/push_post");
          },
        ),
        appBar: AppBar(
          title: TabBar(
            labelColor: Colors.white,
            tabs: [
              Tab(
                text: "发现",
              ),
              Tab(
                text: "好友",
              ),
              Tab(
                text: "回复",
              ),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              children: <Widget>[
                PostsCard(
                  photo:
                      "https://wimg.ruan8.com/uploadimg/image/20180912/20180912161716_99988.jpg",
                  gander: "男",
                  nickname: "猫九",
                  age: 21,
                  body:
                      "哈哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼哈哈",
                  src:
                      "https://wimg.ruan8.com/uploadimg/image/20180912/20180912161717_40052.jpg",
                  type: 1,
                  likenum: 5,
                  chatnum: 16,
                  createTime: 123456,
                  chatButton: () {
                    Navigator.pushNamed(context, "/dongtai_details",
                        arguments: {
                          "photo":
                              "https://wimg.ruan8.com/uploadimg/image/20180912/20180912161716_99988.jpg",
                          "gander": "男",
                          "nickname": "猫九",
                          "age": 21,
                          "body":
                              "哈哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈吼吼吼吼吼吼吼吼吼吼吼吼吼吼吼哈哈",
                          "src":
                              "https://wimg.ruan8.com/uploadimg/image/20180912/20180912161717_40052.jpg",
                          "type": 1,
                          "likenum": 5,
                          "chatnum": 16,
                          "createTime": 123456,
                        });
                  },
                ),
                PostsCard(
                  photo:
                      "https://wimg.ruan8.com/uploadimg/image/20180912/20180912161717_59815.jpg",
                  gander: "男",
                  nickname: "先森",
                  age: 18,
                  body: "所以爱会消失对不对？",
                  src: ipAddress + "/bgm.mp3",
                  type: 2,
                  likenum: 0,
                  chatnum: 3,
                  createTime: 6666,
                  chatButton: () {
                    Navigator.pushNamed(context, "/dongtai_details",
                        arguments: {
                          "photo":
                              "https://wimg.ruan8.com/uploadimg/image/20180912/20180912161717_59815.jpg",
                          "gander": "男",
                          "nickname": "先森",
                          "age": 18,
                          "body": "所以爱会消失对不对？",
                          "src": ipAddress + "/bgm.mp3",
                          "type": 2,
                          "likenum": 0,
                          "chatnum": 3,
                          "createTime": 6666,
                        });
                  },
                ),
                PostsCard(
                  photo:
                      "https://wimg.ruan8.com/uploadimg/image/20180912/20180912161717_59815.jpg",
                  gander: "女",
                  nickname: "翠花",
                  age: 18,
                  body: "所以爱会消失对不对？",
                  src:
                      "https://wimg.ruan8.com/uploadimg/image/20180912/20180912161717_53533.jpg",
                  type: 0,
                  likenum: 1,
                  chatnum: 0,
                  createTime: 6666,
                  chatButton: () {
                    Navigator.pushNamed(context, "/dongtai_details",
                        arguments: {
                          "photo":
                              "https://wimg.ruan8.com/uploadimg/image/20180912/20180912161717_59815.jpg",
                          "gander": "女",
                          "nickname": "翠花",
                          "age": 18,
                          "body": "所以爱会消失对不对？",
                          "src":
                              "https://wimg.ruan8.com/uploadimg/image/20180912/20180912161717_53533.jpg",
                          "type": 0,
                          "likenum": 1,
                          "chatnum": 0,
                          "createTime": 6666,
                        });
                  },
                ),
              ],
            ),
            ListView(
              children: <Widget>[
                PostsCard(
                  photo: "https://pic.17qq.com/uploads/ihdobigjhz.jpeg",
                  gander: "女",
                  nickname: "白雪公主",
                  age: 18,
                  body: "啥也不是",
                  src:
                      "http://wx3.sinaimg.cn/large/415f82b9ly1g9mr9ufbkzj20g00g0q52.jpg",
                  type: 1,
                  likenum: 520,
                  chatnum: 999,
                  createTime: 123456,
                  chatButton: () {
                    Navigator.pushNamed(context, "/dongtai_details",
                        arguments: {
                          "photo":
                              "https://pic.17qq.com/uploads/ihdobigjhz.jpeg",
                          "gander": "女",
                          "nickname": "白雪公主",
                          "age": 18,
                          "body": "啥也不是",
                          "src":
                              "http://wx3.sinaimg.cn/large/415f82b9ly1g9mr9ufbkzj20g00g0q52.jpg",
                          "type": 1,
                          "likenum": 520,
                          "chatnum": 999,
                          "createTime": 123456,
                        });
                  },
                ),
                PostsCard(
                  photo:
                      "https://wimg.ruan8.com/uploadimg/image/20180912/20180912161717_59815.jpg",
                  gander: "男",
                  nickname: "先森",
                  age: 18,
                  body: "所以爱会消失对不对？",
                  src: ipAddress + "/bgm.mp3",
                  type: 2,
                  likenum: 0,
                  chatnum: 3,
                  createTime: 6666,
                  chatButton: () {
                    Navigator.pushNamed(context, "/dongtai_details",
                        arguments: {
                          "photo":
                              "https://wimg.ruan8.com/uploadimg/image/20180912/20180912161717_59815.jpg",
                          "gander": "男",
                          "nickname": "先森",
                          "age": 18,
                          "body": "所以爱会消失对不对？",
                          "src": ipAddress + "/bgm.mp3",
                          "type": 2,
                          "likenum": 0,
                          "chatnum": 3,
                          "createTime": 6666,
                        });
                  },
                ),
                PostsCard(
                  photo:
                      "https://wimg.ruan8.com/uploadimg/image/20180912/20180912161717_59815.jpg",
                  gander: "男",
                  nickname: "先森",
                  age: 18,
                  body: "所以爱会消失对不对？",
                  src:
                      "https://wimg.ruan8.com/uploadimg/image/20180912/20180912161717_53533.jpg",
                  type: 0,
                  likenum: 1,
                  chatnum: 15,
                  createTime: 6666,
                  chatButton: () {
                    Navigator.pushNamed(context, "/dongtai_details",
                        arguments: {
                          "photo":
                              "https://wimg.ruan8.com/uploadimg/image/20180912/20180912161717_59815.jpg",
                          "gander": "男",
                          "nickname": "先森",
                          "age": 18,
                          "body": "所以爱会消失对不对？",
                          "src":
                              "https://wimg.ruan8.com/uploadimg/image/20180912/20180912161717_53533.jpg",
                          "type": 0,
                          "likenum": 1,
                          "chatnum": 15,
                          "createTime": 6666,
                        });
                  },
                ),
              ],
            ),
            ListView(
              children: <Widget>[
                AboutMeCard(
                    photo:
                        "https://wimg.ruan8.com/uploadimg/image/20180912/20180912161717_59815.jpg",
                    gander: "男",
                    nickname: "先森",
                    body: "啥也不是",
                    time: "12:15",
                    id: 102,
                    type: 0,
                    src:
                        "https://wimg.ruan8.com/uploadimg/image/20180912/20180912161717_53533.jpg")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
