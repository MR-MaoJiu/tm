import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission() async {
  final status = await Permission.location.request();

  if (status == PermissionStatus.granted) {
    return true;
  } else {
    debugPrint('需要定位权限!');
    return false;
  }
}
