import 'dart:async';

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:tm/common/animation/animation.dart';
import 'package:tm/common/widgets/widges.dart';

class PostsCard extends StatefulWidget {
  final String photo;
  final String gander;
  final String nickname;
  final int age;
  final String body;
  final String src;
  final int type;
  final int createTime;
  final int likenum;
  final int chatnum;
  final GestureTapCallback chatButton;
  PostsCard({
    @required this.photo,
    @required this.gander,
    @required this.nickname,
    @required this.age,
    @required this.body,
    @required this.src,
    @required this.type,
    @required this.createTime,
    @required this.likenum,
    @required this.chatnum,
    @required this.chatButton,
  });
  @override
  _PostsCardState createState() => _PostsCardState();
}

class _PostsCardState extends State<PostsCard> with TickerProviderStateMixin {
  //设置动画的垂直同步，具体干嘛的不知道，硬性要求吧，后面会用到
//1、声明需要用到的animationCongtroller和animation
  AnimationController animationController; //动画控制器
  Animation animation; //动画类，数值方面
  Animation animationColor; //动画类，颜色方面
  CurvedAnimation curved; //变化类，控制动画的变化种类，默认是匀速变化
//  Future<bool> onLikeButtonTap(bool isLiked, TuChongItem item) {
//    ///send your request here
//    ///
//    final Completer<bool> completer = new Completer<bool>();
//    Timer(const Duration(milliseconds: 200), () {
//      item.isFavorite = !item.isFavorite;
//      item.favorites =
//          item.isFavorite ? item.favorites + 1 : item.favorites - 1;
//
//      // if your request is failed,return null,
//      completer.complete(item.isFavorite);
//    });
//    return completer.future;
//  }

  Widget _body() {
    switch (this.widget.type) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.body,
              textAlign: TextAlign.left,
            ),
            Container()
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.body,
              textAlign: TextAlign.left,
            ),
            Image.network(widget.src),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.body,
              textAlign: TextAlign.left,
            ),
            PlayVoice(
              voicePath: widget.src,
              isMyself: false,
            ),
          ],
        );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //在控件消失的时候释放资源
    animationController.dispose();
  }

  int likenum;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    likenum = widget.likenum;
    animationController = AnimationController(
        duration: Duration(milliseconds: 500), //设置动画的持续时间，这里是500毫秒
        vsync: this //开启垂直同步，这里需要事先引入TickerProviderStateMixin，前面提到过
        );
    //这里设置的是动画的变化效果，parent和curve为必选参数
    curved =
        CurvedAnimation(parent: animationController, curve: Curves.bounceOut);
    //设置动画的数值变化，最后要使用.animate执行动画，参数可为animationController，默认为匀速变化
    animation = Tween(begin: 32.0, end: 40.0).animate(curved);
    //同上方的数值变化，这里设置的是颜色的变化，最后也要加上aniamte才能执行该动画
    animationColor = ColorTween(begin: Colors.black12, end: Colors.redAccent)
        .animate(curved);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 18, right: 18, top: 18),
      decoration: new BoxDecoration(
//          gradient: LinearGradient(colors: [
//            Colors.blueAccent,
//            Colors.lightBlue,
//            Colors.cyan,
//          ]), //背景渐变，颜色由红色渐变为700色域的橙色
          color: Colors.cyan,
          borderRadius: BorderRadius.circular(20), //快速构造一个3px的圆角
          boxShadow: [
            //装饰的阴影策略
            BoxShadow(
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
                blurRadius: 4.0)
          ]),
      child: Column(
        children: <Widget>[
          Container(
            child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: widget.gander == "男"
                              ? Colors.blueAccent
                              : Colors.pinkAccent,
                          width: 2),
                      borderRadius: BorderRadius.circular(42)),
                  child: ClipOval(
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/images/tm.png",
                      image: widget.photo,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                title: Text(widget.nickname),
                subtitle: Text("${widget.age} 岁"),
                trailing:
                    IconButton(icon: Icon(Icons.more_horiz), onPressed: null)),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: _body(),
          ),
          Container(
            margin: EdgeInsets.only(right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.message,
                        color: Colors.black12,
                      ),
                      onPressed: widget.chatButton,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "${widget.chatnum ?? ""}",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                LikeButton(
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        Icons.favorite,
                        color: isLiked ? Colors.redAccent : Colors.black12,
                      );
                    },
                    countBuilder: (int count, bool isLiked, String text) {
                      var color = isLiked ? Colors.redAccent : Colors.black;
                      Widget result;
                      result = Text(
                        text,
                        style: TextStyle(color: color),
                      );
                      return result;
                    },
//                    onTap: (bool isLiked) {
//                      return onLikeButtonTap(isLiked, item);
//                    },
                    likeCount: widget.likenum),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
