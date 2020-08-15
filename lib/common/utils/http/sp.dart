import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// 本地存储
class SpUtil {
  static SpUtil _instance = new SpUtil._();
  factory SpUtil() => _instance;
  static SharedPreferences _prefs;

  SpUtil._();

  static Future<void> init() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  Future<bool> setJSON(String key, dynamic jsonVal) {
    String jsonString = jsonEncode(jsonVal);
    return _prefs.setString(key, jsonString);
  }

  dynamic getJSON(String key) {
    String jsonString = _prefs.getString(key);
    return jsonString == null ? null : jsonDecode(jsonString);
  }

  Future<bool> setString(String key, String string) {
    return _prefs.setString(key, string);
  }

  dynamic getString(String key) {
    return _prefs.getString(key);
  }

  Future<bool> setBool(String key, bool val) {
    return _prefs.setBool(key, val);
  }

  bool getBool(String key) {
    bool val = _prefs.getBool(key);
    return val == null ? false : val;
  }

  Future<bool> remove(String key) {
    return _prefs.remove(key);
  }
}
