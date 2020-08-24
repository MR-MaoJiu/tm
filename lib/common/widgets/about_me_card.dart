import 'package:flutter/material.dart';
import 'package:tm/common/widgets/widges.dart';

class AboutMeCard extends StatefulWidget {
  final String photo;
  final String gander;
  final String nickname;
  final String body;
  final String time;
  final int id;
  final int type;
  final String src;
  AboutMeCard({
    @required this.photo,
    @required this.gander,
    @required this.nickname,
    @required this.body,
    @required this.time,
    @required this.id,
    @required this.type,
    @required this.src,
  });
  @override
  _AboutMeCardState createState() => _AboutMeCardState();
}

class _AboutMeCardState extends State<AboutMeCard> {
  Widget _body() {
    switch (this.widget.type) {
      case 0:
        return Text(
          widget.body,
          textAlign: TextAlign.left,
        );
      case 1:
        return Image.network(
          widget.src,
          height: 50,
        );
      case 2:
        return PlayVoice(
          voicePath: widget.src,
          isMyself: false,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
        subtitle: _body(),
        trailing: Text("${widget.time}"));
  }
}
