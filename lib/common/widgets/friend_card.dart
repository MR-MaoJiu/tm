import 'package:flutter/material.dart';

class FriendCard extends StatefulWidget {
  final String photo;
  final String gander;
  final String nickname;
  final String body;
  final String time;

  FriendCard({
    @required this.photo,
    @required this.gander,
    @required this.nickname,
    @required this.body,
    @required this.time,
  });
  @override
  _FriendCardState createState() => _FriendCardState();
}

class _FriendCardState extends State<FriendCard> {
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
      subtitle: Text("${widget.body}"),
      trailing: widget.time == null
          ? IconButton(icon: Icon(Icons.navigate_next), onPressed: null)
          : Text("${widget.time}"),
      onTap: () {
        Navigator.of(context).pushNamed("/message", arguments: {"jiontype": 1});
      },
    );
  }
}
