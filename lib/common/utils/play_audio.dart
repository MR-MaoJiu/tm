import 'package:audioplayers/audioplayers.dart';
import 'package:tm/common/values/server_address.dart';

import 'http/global.dart';

class PlayAudio {
  static AudioPlayer _audioPlayer = AudioPlayer();
  static play() async {
    await _audioPlayer
        .setReleaseMode(ReleaseMode.LOOP)
        .then((value) => _audioPlayer.play(ipAddress + "/bgm.mp3"));
  }

  static stop() async {
    await _audioPlayer.stop();
  }

  static isPlay() {
    Global.isPlay == "true" ? play() : stop();
  }
}
