import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:tm/common/utils/utils.dart';

class ChatRow extends StatelessWidget {
  final String avatarLocalSavedPath;
  final Widget content;
  final bool isMyself;
  final GestureTapCallback onTapContent;
  final bool isCanTap;
  ChatRow(
      {@required this.avatarLocalSavedPath,
      @required this.content,
      @required this.isMyself,
      this.onTapContent,
      this.isCanTap});

  @override
  Widget build(BuildContext context) {
    if (isMyself) {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Bubble(
              margin: BubbleEdges.only(top: 10),
              alignment: Alignment.topRight,
              nip: BubbleNip.rightTop,
              child: Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 2),
                  child: content),
            ),
            ClipOval(
              child: Image.network(
                this.avatarLocalSavedPath,
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              child: ClipOval(
                child: Image.network(
                  this.avatarLocalSavedPath,
                  width: duSetWidth(30),
                  fit: BoxFit.cover,
                ),
              ),
              onTap: () {
                //  Navigator.of(context).pushNamed("/setting_details");
              },
            ),
            Bubble(
              margin: BubbleEdges.only(top: 10),
              alignment: Alignment.topLeft,
              nip: BubbleNip.leftTop,
              child: Container(
                  constraints: BoxConstraints(
                      maxWidth:
                          duSetWidth(MediaQuery.of(context).size.width / 2)),
                  child: this.isCanTap
                      ? GestureDetector(
                          child: content, onTap: this.onTapContent)
                      : content),
            ),
          ],
        ),
      );
    }
  }
}
