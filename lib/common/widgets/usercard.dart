import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UsersCard extends Dialog {
  String nickname;
  int age;
  String gander;
  int onlinestatus;
  String src;
  String address;
  Function onCloseEvent;
  Function onPositivePressEvent;

  UsersCard({
    Key key,
    @required this.nickname,
    @required this.src,
    @required this.gander,
    @required this.onlinestatus,
    @required this.age,
    @required this.address,
    this.onPositivePressEvent,
    @required this.onCloseEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: ShapeDecoration(
                color: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              margin: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: <Widget>[
                        Center(
                          child:
                              Text("收获一枚${gander == "男" ? "帅气小哥哥" : "可爱小姐姐"}"),
                        ),
                        GestureDetector(
                          onTap: this.onCloseEvent,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.close,
                              color: Color(0xffe0e0e0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 85,
                    height: 85,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: gander == "男"
                                ? Colors.blueAccent
                                : Colors.pinkAccent,
                            width: 2),
                        borderRadius: BorderRadius.circular(42)),
                    child: ClipOval(
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/images/tm.png",
                        image: src,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(minHeight: 180.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: IntrinsicHeight(
                        child: Column(
                          children: <Widget>[
                            Text(
                              nickname,
                              style: TextStyle(
                                  color: onlinestatus == 0
                                      ? Colors.black54
                                      : Colors.black,
                                  fontSize: 16.0),
                            ),
                            Text(
                              "$age 岁",
                              style: TextStyle(fontSize: 16.0),
                            ),
                            Text(
                              address,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Color(0xffe0e0e0),
                    height: 1.0,
                  ),
                  this._buildBottomButtonGroup(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtonGroup() {
    var widgets = <Widget>[];
//    if (negativeText != null && negativeText.isNotEmpty)
//      widgets.add(_buildBottomCancelButton());
//    if (positiveText != null && positiveText.isNotEmpty)
    widgets.add(_buildBottomPositiveButton());
    return Flex(
      direction: Axis.horizontal,
      children: widgets,
    );
  }

//  Widget _buildBottomCancelButton() {
//    return  Flexible(
//      fit: FlexFit.tight,
//      child:  FlatButton(
//        onPressed: onCloseEvent,
//        child:  Text(
//          negativeText,
//          style: TextStyle(
//            fontSize: 16.0,
//          ),
//        ),
//      ),
//    );
//  }

  Widget _buildBottomPositiveButton() {
    return Flexible(
      fit: FlexFit.tight,
      child: IconButton(
        onPressed: onPositivePressEvent,
        icon: Icon(
          Icons.chat,
          color: Colors.teal,
        ),
      ),
    );
  }
}
