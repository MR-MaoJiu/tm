import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tm/common/utils/utils.dart';

///onPressedFace 笑脸面板回调
///onPressedMore 更多回调
///onPressedVoice 语音回调
///inputTapCallBack 输入框触碰回调
/// messageCallBack 消息回调
class MessageInput extends StatefulWidget {
  final GestureTapCallback onPressedFace; //笑脸面板回调
  final GestureTapCallback onPressedMore; //更多回调
  final GestureTapCallback onPressedVoice; //语音回调
  final GestureTapCallback onPressedSend; //语音回调
  final inputTapCallBack; //输入框触碰回调
  final messageCallBack; //消息回调
  final textEditingController;
  MessageInput({
    Key key,
    @required this.onPressedFace,
    @required this.onPressedMore,
    @required this.onPressedVoice,
    @required this.inputTapCallBack,
    this.onPressedSend,
    this.messageCallBack,
    this.textEditingController,
  }) : super(key: key);
  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  var _msgInputController = TextEditingController();
  bool _isSend = false; //是否发送按钮
  @override
  Widget build(BuildContext context) {
    // this.widget.textEditingController(_msgInputController);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.widget.textEditingController(_msgInputController);
      _msgInputController.text.length > 0 ? _isSend = true : _isSend = false;
      this.widget.messageCallBack(_msgInputController.text);
      //print("单次Frame绘制回调"); // 只回调一次
    });
    return Container(
      height: duSetHeight(45),
      child: Row(
        children: <Widget>[
          //语音按钮
          Expanded(
            child: FlatButton(
              child: Icon(
                Icons.mic,
              ),
              onPressed: this.widget.onPressedVoice,
            ),
            flex: 1,
          ),
          //输入框
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              //设置 child 居中
              alignment: Alignment(0, 0),
              height: duSetHeight(50),
              width: duSetWidth(300),
              //边框设置
              decoration: new BoxDecoration(
                //背景
                color: Colors.black26,
                //设置四周圆角 角度
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              child: TextField(
                controller: _msgInputController,
                maxLines: 5,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(300) //限制长度
                ],
                decoration: InputDecoration(
                  hintText: "   说点什么吧！",
                  border: InputBorder.none,
                ),
//                onChanged: (changed) {
//                  setState(() {
//                    changed.length > 0 ? _isSend = true : _isSend = false;
//                    this.widget.messageCallBack(changed);
//                  });
//                },
                onTap: () {
                  //关闭所有的面板
                  setState(() {
                    this.widget.inputTapCallBack("closeAllPlan");
                    //this.widget.textEditingController(_msgInputController);
                  });
                },
              ),
            ),
            flex: 5,
          ),
          //笑脸
          Expanded(
            child: FlatButton(
                child: Icon(
                  Icons.sentiment_satisfied,
                ),
                padding: EdgeInsets.all(10),
                onPressed: this.widget.onPressedFace),
          ),
          Expanded(
            child: _isSend
                ? FlatButton(
                    padding: EdgeInsets.all(1),
                    child: Container(
                      child: Text(
                        "发送",
                        style: TextStyle(),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle, // 圆形，使用圆形时不可以使用borderRadius
                      ),
                    ),
                    onPressed: this.widget.onPressedSend)
                : FlatButton(
                    child: Icon(Icons.add_circle_outline),
                    onPressed: this.widget.onPressedMore),
            flex: 1,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _msgInputController.dispose();
    super.dispose();
  }
}
