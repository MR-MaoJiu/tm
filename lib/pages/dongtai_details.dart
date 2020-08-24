import 'dart:async';
import 'dart:io';

import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tm/common/utils/utils.dart';
import 'package:tm/common/values/values.dart';
import 'package:tm/common/widgets/widges.dart';

class DongTaiDetails extends StatefulWidget {
  @override
  _DongTaiDetailsState createState() => _DongTaiDetailsState();
}

class _DongTaiDetailsState extends State<DongTaiDetails> {
  Map args;
  ScrollController _msgcontroller = ScrollController();
  ScrollController _chatcontroller = ScrollController();
  bool _isOpenPlanFace = false; //开启标签面板
  bool _isOpenPlanMore = false; //开启更多面板
  bool _isOpenPlanVoice = false; //开启语音面板
  TextEditingController _controller = TextEditingController();
  var _voiceTitle = "按住说话"; //语音标题
  final picker = ImagePicker();
  File _imgPath;
  var _messageData; //消息数据

  List<Map> msg = [
    {
      "photo":
          "https://wimg.ruan8.com/uploadimg/image/20180912/20180912161717_59815.jpg",
      "gander": "男",
      "nickname": "先森",
      "age": 18,
      "body": "@先森 所以爱会消失对不对？",
      "src": ipAddress + "/bgm.mp3",
      "type": 2,
      "likenum": 0,
      "createTime": 6666,
    },
    {
      "photo": "https://pic.17qq.com/uploads/ihdobigjhz.jpeg",
      "gander": "女",
      "nickname": "白雪公主",
      "age": 18,
      "body": "啥也不是",
      "src": "http://wx3.sinaimg.cn/large/415f82b9ly1g9mr9ufbkzj20g00g0q52.jpg",
      "type": 1,
      "likenum": 520,
      "createTime": 123456,
    }
  ];
  //Emoji面板
  Widget _buildFacePlan(context) {
    _isOpenPlanFace ? FocusScope.of(context).requestFocus(FocusNode()) : "";

    return _isOpenPlanFace
        ? Container(
            color: Colors.black12,
            child: EmojiPicker(
              rows: 4,
              columns: 8,
              onEmojiSelected: (emoji, category) {
                _controller.text += emoji.emoji;
              },
            ),
          )
        : Container();
  }

//更多面板
  Widget _buildMorePlan(context) {
    _isOpenPlanMore ? FocusScope.of(context).requestFocus(FocusNode()) : "";

    return //更多面板
        _isOpenPlanMore
            ? Container(
                color: Colors.black12,
                height: duSetHeight(189),
                child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, //横轴三个子widget
                    ),
                    children: <Widget>[
                      MorPlanButton(
                        onButtonTap: () {
                          _getImageFromGallery();
                        },
                        icon: Image.asset("assets/images/photo.png"),
                        title: "图片",
                        color: Colors.white,
                      ),
                      MorPlanButton(
                        onButtonTap: () {
                          _getImageFromCamera();
                        },
                        icon: Image.asset("assets/images/camera.png"),
                        title: "相机",
                        color: Colors.white,
                      )
                    ]),
              )
            : Container();
  }

//语音面板
  Widget _buildVoicePlan(title, context, {widget}) {
    _isOpenPlanVoice ? FocusScope.of(context).requestFocus(FocusNode()) : "";

    return //语音面板
        _isOpenPlanVoice
            ? Container(
                color: Colors.black12,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      title,
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      height: duSetHeight(100),
                      child: widget,
                    ),
                  ],
                ),
                height: duSetHeight(190),
                width: duSetWidth(500),
              )
            : Container();
  }

  //相机选择
  Future _getImageFromCamera() async {
    picker.getImage(source: ImageSource.camera).then((value) {
      setState(() {
        _imgPath = File(value.path);
        if (_imgPath != null) {
//          _msg.add(ChatRow(
//              avatarLocalSavedPath:
//              "https://pic.17qq.com/uploads/kpgnfgqnky.jpeg",
//              content: Image.file(_imgPath),
//              isMyself: true));

        }
      });
    });
  }

  //相册选择
  //相册选择
  Future _getImageFromGallery() async {
    picker.getImage(source: ImageSource.gallery).then((value) {
      setState(() {
        _imgPath = File(value.path);
        if (_imgPath != null) {
//          _msg.add(ChatRow(
//              avatarLocalSavedPath:
//              "https://pic.17qq.com/uploads/kpgnfgqnky.jpeg",
//              content: Image.file(_imgPath),
//              isMyself: true));
//          scrollMsgBottom();
        }
      });
    });
  }
// 滚动消息至聊天底部
//  void scrollMsgBottom() {
//    Timer(
//        Duration(milliseconds: 100),
//        () => _msgcontroller.position
//            .moveTo(_msgcontroller.position.maxScrollExtent - 170));
//  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _chatcontroller.addListener(() => scrollMsgBottom());
    _isOpenPlanFace = false;
    _isOpenPlanMore = false;
    _isOpenPlanVoice = false;
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    return WillPopScope(
        // ignore: missing_return
        onWillPop: () {
          if (_isOpenPlanFace || _isOpenPlanMore || _isOpenPlanVoice) {
            _isOpenPlanVoice = false;
            _isOpenPlanMore = false;
            _isOpenPlanFace = false;
            FocusScope.of(context).requestFocus(FocusNode());
          } else {
            Navigator.pop(context);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("动态详情"),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: ListView(
                    controller: _msgcontroller,
                    children: <Widget>[
                      PostsCard(
                        photo: args["photo"],
                        gander: args["gander"],
                        nickname: args["nickname"],
                        age: args["age"],
                        body: args["body"],
                        src: args["src"],
                        type: args["type"],
                        createTime: args["createTime"],
                        likenum: args["likenum"],
                        chatnum: args["chatnum"],
                        chatButton: () {
                          _controller.text += "@${args["nickname"]} ";
                        },
                      ),
                      Divider(),
                      Text("评论${args["chatnum"]}"),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                            controller: _chatcontroller,
                            itemCount: msg.length,
                            itemBuilder: (BuildContext context, int index) =>
                                PostsCard(
                                    photo: msg[index]["photo"],
                                    gander: msg[index]["gander"],
                                    nickname: msg[index]["nickname"],
                                    age: msg[index]["age"],
                                    body: msg[index]["body"],
                                    src: msg[index]["src"],
                                    type: msg[index]["type"],
                                    createTime: msg[index]["createTime"],
                                    likenum: msg[index]["likenum"],
                                    chatnum: msg[index]["chatnum"],
                                    chatButton: () {
                                      _controller.text +=
                                          "@${msg[index]["nickname"]} ";
                                    })),
                      )
                    ],
                  ),
                ),
                flex: 12,
              ),
              Container(
                child: MessageInput(
                  onPressedFace: () {
                    setState(() {
                      _isOpenPlanVoice = false;
                      _isOpenPlanMore = false;
                      _isOpenPlanFace = !_isOpenPlanFace;
                    });
                  },
                  onPressedMore: () {
                    setState(() {
                      _isOpenPlanVoice = false;
                      _isOpenPlanFace = false;
                      _isOpenPlanMore = !_isOpenPlanMore;
                    });
                  },
                  onPressedVoice: () {
                    setState(() {
                      _isOpenPlanFace = false;
                      _isOpenPlanMore = false;
                      _isOpenPlanVoice = !_isOpenPlanVoice;
                    });
                  },
                  inputTapCallBack: (value) {
                    setState(() {
                      _isOpenPlanVoice = false;
                      _isOpenPlanFace = false;
                      _isOpenPlanMore = false;
                    });
                  },
                  onPressedSend: () {
                    //发送文字消息
                    debugPrint(
                        "=========================>Send: ${_messageData}");
                    var _temp = _messageData;
//                _msg.add(ChatRow(
//                    avatarLocalSavedPath:
//                        "https://pic.17qq.com/uploads/kpgnfgqnky.jpeg",
//                    content: Text(
//                      _temp,
//                      style: TextStyle(color: Colors.black),
//                    ),
//                    isMyself: true));
                    _controller.clear();

                    // FocusScope.of(context).requestFocus(FocusNode());
                  },
                  messageCallBack: (_value) {
                    _messageData = _value;
                  },
                  textEditingController: (_ctrl) {
                    setState(() {
                      _controller = _ctrl;
                    });
                  },
                ),
              ),
              //Emoji面板
              _buildFacePlan(context),
              //更多面板
              _buildMorePlan(context),
              //语音面板
              _buildVoicePlan(
                _voiceTitle,
                context,
                widget: VoiceButton(
                  startRecord: () {
                    debugPrint("=====================>开始录制了");
                  },
                  stopRecord: (path, time) {
                    debugPrint("=====================>$path");
//                _msg.add(ChatRow(
//                    avatarLocalSavedPath:
//                    "https://pic.17qq.com/uploads/kpgnfgqnky.jpeg",
//                    content:
//                    PlayVoice(voicePath: path, time: time, isMyself: true),
//                    isMyself: true));
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
