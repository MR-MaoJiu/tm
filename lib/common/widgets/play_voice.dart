import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tm/common/animation/animation.dart';

///voicePath 音频路径
///time 音频时长
///isMyself 是否自己
class PlayVoice extends StatefulWidget {
  final String voicePath;
  final double time;
  final bool isMyself;
  PlayVoice(
      {Key key,
      @required this.voicePath,
      @required this.time,
      @required this.isMyself})
      : super(key: key);
  @override
  _PlayVoiceState createState() => _PlayVoiceState();
}

class _PlayVoiceState extends State<PlayVoice> {
  List<String> _assetLeftList = new List();
  List<String> _assetRightList = new List();
  bool _isStop = false;
  String _playTime;
  AudioPlayer _audioPlayer = AudioPlayer();
  @override
  void initState() {
    widget.time != null
        ? _playTime = this.widget.time.round().toString()
        : _playTime = null;
    debugPrint(_playTime);
    _isStop = false;
    super.initState();
    _assetLeftList.add("assets/images/left_voice_1.png");
    _assetLeftList.add("assets/images/left_voice_2.png");
    _assetLeftList.add("assets/images/left_voice_3.png");
    _assetRightList.add("assets/images/right_voice_1.png");
    _assetRightList.add("assets/images/right_voice_2.png");
    _assetRightList.add("assets/images/right_voice_3.png");
    _audioPlayer.onPlayerStateChanged.listen((s) {
      debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>$s");

      if (s == AudioPlayerState.PLAYING) {
        setState(() {
          _isStop = true;
          debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>$_isStop");
        });
      } else if (s == AudioPlayerState.STOPPED) {
        setState(() {
          _isStop = false;
          debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>$_isStop");
        });
      } else if (s == AudioPlayerState.COMPLETED) {
        setState(() {
          _isStop = false;
          debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>$_isStop");
        });
      }
    }, onError: (msg) {
      setState(() {
        _isStop = true;
      });
    });
  }

  Widget _buildLeftVoice(_isImage, action) {
    if (_playTime != null) {
      File(this.widget.voicePath).exists().then((value) {
        if (mounted) {
          setState(() {
            value
                ? _playTime = this.widget.time.round().toString()
                : _playTime = "音频已失效";
          });
        }
      });
    }

    return _isImage
        ? MaterialButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  "assets/images/voice_left.png",
                  width: 50,
                  height: 50,
                  color: Colors.cyanAccent,
                ),
                _playTime != null
                    ? Text(
                        "$_playTime 秒",
                        style: TextStyle(color: Colors.cyanAccent),
                      )
                    : Container(),
              ],
            ),
            onPressed: action,
          )
        : MaterialButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                VoiceAnimationImage(
                  _assetLeftList,
                  width: 50,
                  height: 50,
                  isStop: _isStop,
                ),
                _playTime != null
                    ? Text("$_playTime 秒",
                        style: TextStyle(color: Colors.cyanAccent))
                    : Container(),
              ],
            ),
            onPressed: action,
          );
  }

  Widget _buildRightVoice(_isImage, action) {
    if (_playTime != null) {
      File(this.widget.voicePath).exists().then((value) {
        if (mounted) {
          setState(() {
            value
                ? _playTime = this.widget.time.round().toString()
                : _playTime = "音频已失效";
          });
        }
      });
    }
    return _isImage
        ? MaterialButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _playTime != null
                    ? Text("$_playTime 秒",
                        style: TextStyle(color: Colors.cyanAccent))
                    : Container(),
                Image.asset(
                  "assets/images/voice_right.png",
                  width: 50,
                  height: 50,
                  color: Colors.cyanAccent,
                ),
              ],
            ),
            onPressed: action,
          )
        : MaterialButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _playTime != null
                    ? Text("$_playTime 秒",
                        style: TextStyle(color: Colors.cyanAccent))
                    : Container(),
                VoiceAnimationImage(
                  _assetRightList,
                  width: 50,
                  height: 50,
                  isStop: _isStop,
                ),
              ],
            ),
            onPressed: action,
          );
  }

  playVoice(path) {
    _audioPlayer.play(path).catchError((_val) {
      debugPrint("========================>$_val");
      setState(() {
        _isStop = false;
      });
    });
  }

  stopVoice() {
    _audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return this.widget.isMyself
        ? _buildRightVoice(!_isStop, () {
            setState(() {
              if (_playTime == "音频已失效") {
                Fluttertoast.showToast(
                  fontSize: 12.0,
                  msg: "音频已失效",
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                  textColor: Colors.black87,
                  gravity: ToastGravity.BOTTOM,
                );
              } else {
                debugPrint("$_isStop");
                _isStop = !_isStop;
                //playVoice(this.widget.voicePath);
                _isStop ? playVoice(this.widget.voicePath) : stopVoice();
              }
            });
          })
        : _buildLeftVoice(!_isStop, () {
            setState(() {
              //playVoice(this.widget.voicePath);
              if (_playTime == "音频已失效") {
                Fluttertoast.showToast(
                  fontSize: 12.0,
                  msg: "音频已失效",
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                  textColor: Colors.black87,
                  gravity: ToastGravity.BOTTOM,
                );
              } else {
                debugPrint("$_isStop");
                _isStop = !_isStop;
                //playVoice(this.widget.voicePath);
                _isStop ? playVoice(this.widget.voicePath) : stopVoice();
              }
            });
          });
  }

  callBackO(bool stop) {
    print(stop);
  }
}
