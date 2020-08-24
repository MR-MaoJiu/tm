import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tm/common/utils/utils.dart';

class MorPlanButton extends StatefulWidget {
  final GestureTapCallback onButtonTap;
  final Image icon;
  final String title;
  final Color color;
  MorPlanButton(
      {Key key,
      @required this.onButtonTap,
      @required this.icon,
      @required this.title,
      this.color})
      : super(key: key);
  @override
  _MorPlanButtonState createState() => _MorPlanButtonState();
}

class _MorPlanButtonState extends State<MorPlanButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: this.widget.color,
      margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
      child: Column(
        children: <Widget>[
          Container(
            width: duSetWidth(40),
            height: duSetHeight(40),
            decoration: BoxDecoration(
                color: this.widget.color,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: FlatButton(
              onPressed: this.widget.onButtonTap,
              child: this.widget.icon,
              //  color: this.widget.color,
            ),
          ),
          Text(
            this.widget.title,
          )
        ],
      ),
    );
  }
}
