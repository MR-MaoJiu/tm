import 'dart:io';

import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_record/flutter_plugin_record.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tm/common/utils/utils.dart';
import 'package:tm/common/widgets/widges.dart';

class PushPost extends StatefulWidget {
  @override
  _PushPostState createState() => _PushPostState();
}

class _PushPostState extends State<PushPost> {
  bool _isOpenPlanFace = false; //开启标签面板
  bool _isOpenPlanMore = true; //开启更多面板
  bool _isOpenPlanVoice = false; //开启语音面板
  var _voiceTitle = "按住说话"; //语音标题
  TextEditingController _controller = TextEditingController();
  FlutterPluginRecord recordPlugin = new FlutterPluginRecord(); //初始化录音
  File _image;
  final picker = ImagePicker();
  String _path;
  double _time;
  //相册选择
  Future _getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  //Emoji面板
  Widget _buildFacePlan(context) {
    _isOpenPlanFace ? FocusScope.of(context).requestFocus(FocusNode()) : "";

    return _isOpenPlanFace
        ? Container(
            child: EmojiPicker(
              rows: 4,
              columns: 8,
              onEmojiSelected: (emoji, category) {
                setState(() {
                  _controller.text += emoji.emoji;
                });
              },
            ),
          )
        : Container();
  }

//更多面板
  Widget _buildMorePlan(context) {
    _isOpenPlanMore ? FocusScope.of(context).requestFocus(FocusNode()) : "";

    return _isOpenPlanMore
        ? Container(
            height: duSetHeight(189),
            padding: EdgeInsets.only(bottom: 15),
            child: FlatButton(
              onPressed: () {
                _path = null;
                if (_image == null) {
                  _getImageFromGallery();
                } else {
                  setState(() {
                    _image = null;
                  });
                }
              },
              child: _image == null
                  ? Container(
                      width: duSetWidth(150),
                      height: duSetHeight(150),
                      child: Icon(
                        Icons.add,
                        size: 80,
                        color: Colors.cyan,
                      ),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(6.0, 6.0), //阴影xy轴偏移量
                                blurRadius: 20.0, //阴影模糊程度
                                spreadRadius: 5.0 //阴影扩散程度
                                )
                          ],
                          border:
                              Border.all(color: Colors.cyanAccent, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    )
                  : Container(
                      width: duSetWidth(150),
                      height: duSetHeight(150),
                      child: Icon(
                        Icons.close,
                        size: 80,
                        color: Colors.red,
                      ),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(6.0, 6.0), //阴影xy轴偏移量
                                blurRadius: 20.0, //阴影模糊程度
                                spreadRadius: 5.0 //阴影扩散程度
                                )
                          ],
                          border: Border.all(color: Colors.red, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
            ),
//                _image != null
//                    ? IconButton(
//                        alignment: Alignment.center,
//                        icon: Icon(
//                          Icons.close,
//                          color: Colors.red,
//                        ),
//                        onPressed: () {
//                          setState(() {
//                            _image = null;
//                          });
//                        })
//                    : Container(),
          )
        : Container();
  }

//语音面板
  Widget _buildVoicePlan(title, context, {widget}) {
    _isOpenPlanVoice ? FocusScope.of(context).requestFocus(FocusNode()) : "";

    return _isOpenPlanVoice
        ? Container(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("发布动态"),
        actions: <Widget>[FlatButton(onPressed: () {}, child: Text("发布"))],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
                color: Colors.black12,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextField(
                        controller: _controller,
                        maxLines: 8,
                        maxLength: 500,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 15),
                          fillColor: Color(0XFFFFF8F4),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            /*边角*/
                            borderRadius: BorderRadius.all(
                              Radius.circular(5), //边角为5
                            ),
                            borderSide: BorderSide(
                              color: Colors.white, //边线颜色为白色
                              width: 1, //边线宽度为2
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white, //边框颜色为白色
                              width: 1, //宽度为5
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5), //边角为30
                            ),
                          ),
                        ),
                      ),
                    ),
                    _path != null
                        ? FlatButton(
                            onPressed: null,
                            child: PlayVoice(
                                voicePath: _path, time: _time, isMyself: false))
                        : Container(),
                    _image != null
                        ? Expanded(
                            child: Container(
                            child: Image.file(
                              _image,
//                              height: duSetHeight(120),
                            ),
                            margin: EdgeInsets.all(15),
                          ))
                        : Container(),
                  ],
                )),
            flex: 12,
          ),
          //消息输入框
          Container(
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.photo),
                    onPressed: () {
                      setState(() {
                        _isOpenPlanMore = true;
                        _isOpenPlanFace = false;
                        _isOpenPlanVoice = false;
                      });
                    }),
                IconButton(
                    icon: Icon(Icons.mic),
                    onPressed: () {
                      setState(() {
                        _isOpenPlanMore = false;
                        _isOpenPlanFace = false;
                        _isOpenPlanVoice = true;
                      });
                    }),
                IconButton(
                    icon: Icon(Icons.tag_faces),
                    onPressed: () {
                      setState(() {
                        _isOpenPlanMore = false;
                        _isOpenPlanFace = true;
                        _isOpenPlanVoice = false;
                      });
                    }),
              ],
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
                debugPrint("音频录制=====================>$path");
                _image = null;
                setState(() {
                  if (path != "cancel") {
                    _path = path;
                    _time = time;
                  } else {
                    _path = null;
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
