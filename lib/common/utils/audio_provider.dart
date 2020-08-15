import 'dart:async';

import 'package:flutter/material.dart';

class AudioProvider extends ChangeNotifier {
  String isplay = "true";
  
  AudioProvider(string) {
    isplay = string;
    notifyListeners();
  }
}
