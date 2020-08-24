import 'dart:async';
import 'dart:io';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_record/flutter_plugin_record.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tm/common/utils/play_audio.dart';
import 'package:tm/common/utils/utils.dart';
import 'package:tm/common/widgets/widges.dart';

///消息详情
class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

Map args;
bool _isOpenPlanFace = false; //开启标签面板
bool _isOpenPlanMore = false; //开启更多面板
bool _isOpenPlanVoice = false; //开启语音面板
var _voiceTitle = "按住说话"; //语音标题
var _messageData; //消息数据
TextEditingController _controller;
FlutterPluginRecord recordPlugin = new FlutterPluginRecord(); //初始化录音
List<ChatRow> _msg = List(); //消息列表
ScrollController _msgcontroller = ScrollController();
String _markTitle;
String _markPath;
final picker = ImagePicker();
File _imgPath;
//MessageListChild _child; //好友数据
//MessageProvider provider = MessageProvider();
//MessageListProvider _messageListProvider = MessageListProvider();
//MessageEntity entity = MessageEntity();
List<Map<String, dynamic>> _msglist;

//插入聊天记录
//insert(deviceid, isMy, type, msgJson) async {
//  entity.deviceid = deviceid;
//  entity.isMy = isMy;
//  entity.type = type;
//  entity.msgJson = msgJson;
//  provider.insert(entity);
//}

//addMessageList(message) {
//  _child.message = message;
//  //插入之前先去判断表内数据是否存在如果存在就更新message字段否则就插入
//  _messageListProvider.getMessageInfo(entity.deviceid).then((value) {
//    if (value != null) {
//      //更新
//      _messageListProvider.update(_child);
//    } else {
//      //插入
//      _messageListProvider.insert(_child);
//    }
//  });
//}

//查询
//select(cid) {
//  debugPrint("==============================>查询数据库$cid");
//  provider.getMessageInfo(cid).then((value) {
//    _msglist = value;
//    if (_msglist != null) {
//      for (int i = 0; i < _msglist.length; i++) {
//        switch (MessageEntity.fromJson(_msglist[i]).type) {
//          case 0:
//            _msg.add(ChatRow(
//                isCanTap: false,
//                avatarLocalSavedPath:
//                    "${MessageEntity.fromJson(_msglist[i]).isMy == 1 ? _child.imgsrc : "https://pic.17qq.com/uploads/kpgnfgqnky.jpeg"}",
//                content: Text(
//                  " ${MessageEntity.fromJson(_msglist[i]).msgJson}",
//                ),
//                isMyself: MessageEntity.fromJson(_msglist[i]).isMy == 0));
//            break;
//          case 1:
//            var _vjson = MessageEntity.fromJson(_msglist[i]).msgJson;
//            _msg.add(ChatRow(
//                isCanTap: true,
//                avatarLocalSavedPath:
//                    "${MessageEntity.fromJson(_msglist[i]).isMy == 1 ? _child.imgsrc : "https://pic.17qq.com/uploads/kpgnfgqnky.jpeg"}",
//                content: PlayVoice(
//                  voicePath: voiceEntityFromJson(_vjson).path,
//                  time: voiceEntityFromJson(_vjson).time,
//                  isMyself: true,
//                ),
//                isMyself: MessageEntity.fromJson(_msglist[i]).isMy == 0));
//            break;
//          case 2:
//            var _json = MessageEntity.fromJson(_msglist[i]).msgJson;
//            debugPrint("====================================>>$_json");
//            LatLng _lat = LatLng(mapEntityFromJson(_json).latitude,
//                mapEntityFromJson(_json).longitude);
//            var tit = mapEntityFromJson(_json).markMsg;
//            debugPrint(
//                "===================================================>$tit  ${_lat.longitude}");
//            _msg.add(ChatRow(
//                isCanTap: true,
//                avatarLocalSavedPath:
//                    "${MessageEntity.fromJson(_msglist[i]).isMy == 1 ? _child.imgsrc : "https://pic.17qq.com/uploads/kpgnfgqnky.jpeg"}",
//                content: Stack(
//                  alignment: Alignment.bottomCenter,
//                  children: <Widget>[
//                    Image.asset("assets/images/map.png"),
//                    Text(
//                      "点击查看位置详情",
//                    )
//                  ],
//                ),
//                onTapContent: () {
//                  debugPrint("弹出地图======================>");
//                  showDialog(
//                    context: myGlobals.scaffoldKey.currentContext,
//                    child: AmapWidget(
//                      latLng: _latLng,
//                      markers: <MarkerOption>[
//                        MarkerOption(
//                          latLng: _latLng,
//                          title: _markTitle,
//                          widget: CircleAvatar(
//                            backgroundImage: (NetworkImage(
//                              _markPath,
//                            )),
//                          ),
//                        ),
//                      ],
//                    ),
//                  );
//                },
//                isMyself: MessageEntity.fromJson(_msglist[i]).isMy == 0));
//            break;
//          case 3:
//            _msg.add(ChatRow(
//                isCanTap: true,
//                avatarLocalSavedPath:
//                    "${MessageEntity.fromJson(_msglist[i]).isMy == 1 ? _child.imgsrc : "https://pic.17qq.com/uploads/kpgnfgqnky.jpeg"}",
//                content: Image.network(
//                  "${MessageEntity.fromJson(_msglist[i]).msgJson}",
//                  width: duSetWidth(100),
//                ),
//                onTapContent: () {
//                  debugPrint("弹出图片======================>");
//                  showDialog(
//                    context: myGlobals.scaffoldKey.currentContext,
//                    child: PhotoView(
//                      imageProvider: NetworkImage(
//                          "${MessageEntity.fromJson(_msglist[i]).msgJson}"),
//                    ),
//                  );
//                },
//                isMyself: MessageEntity.fromJson(_msglist[i]).isMy == 0));
//            break;
//        }
//      }
//      scrollMsgBottom(); //跳到底部
//    }
//  });
//}

// 滚动消息至聊天底部
void scrollMsgBottom() {
  Timer(Duration(milliseconds: 100),
      () => _msgcontroller.jumpTo(_msgcontroller.position.maxScrollExtent));
}

//构建消息列表
Widget _buildMsgList() {
  return ListView.builder(
    itemCount: _msg.length != null ? _msg.length : 0,
    itemBuilder: (context, index) => _msg[index],
    padding: const EdgeInsets.only(left: 9, right: 9, bottom: 15, top: 15),
    controller: _msgcontroller,
  );
}

Global myGlobals = new Global();

class _MessagePageState extends State<MessagePage> {
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
          _msg.add(ChatRow(
              avatarLocalSavedPath:
                  "https://pic.17qq.com/uploads/kpgnfgqnky.jpeg",
              content: Image.file(_imgPath),
              isMyself: true));
          scrollMsgBottom();
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
          _msg.add(ChatRow(
              avatarLocalSavedPath:
                  "https://pic.17qq.com/uploads/kpgnfgqnky.jpeg",
              content: Image.file(_imgPath),
              isMyself: true));
          scrollMsgBottom();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _isOpenPlanFace = false;
    _isOpenPlanMore = false;
    _isOpenPlanVoice = false;
//    _child = widget.child;
//    debugPrint(
//        "=============================>${_child.deviceid}   ${_child.cname} ");
    //实例化对象
    scrollMsgBottom(); //跳到底部
//    初始化
    recordPlugin.init();
    //清空消息
    _msg.clear();
//    //加载消息
//    _child != null ? select(_child.deviceid) : null;
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
          if (args["jointype"] == 0) {
            PlayAudio.isPlay();
          }
          Navigator.pop(context);
        }
        ;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("聊天"),
        ),
        body: Column(children: <Widget>[
          //聊天框
          Expanded(
            child: GestureDetector(
              onTap: () {
                _isOpenPlanVoice = false;
                _isOpenPlanMore = false;
                _isOpenPlanFace = false;
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                width: duSetWidth(500),
                child: _buildMsgList(),
                color: Colors.black12,
              ),
            ),
            flex: 12,
          ),
          //消息输入框
          MessageInput(
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
              debugPrint("=========================>Send: ${_messageData}");
              var _temp = _messageData;
              _msg.add(ChatRow(
                  avatarLocalSavedPath:
                      "https://pic.17qq.com/uploads/kpgnfgqnky.jpeg",
                  content: Text(
                    _temp,
                    style: TextStyle(color: Colors.black),
                  ),
                  isMyself: true));
              _controller.clear();
              scrollMsgBottom();
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
                _msg.add(ChatRow(
                    avatarLocalSavedPath:
                        "https://pic.17qq.com/uploads/kpgnfgqnky.jpeg",
                    content:
                        PlayVoice(voicePath: path, time: time, isMyself: true),
                    isMyself: true));
                scrollMsgBottom();
              },
            ),
          ),
        ]),
      ),
    );
  }
}
