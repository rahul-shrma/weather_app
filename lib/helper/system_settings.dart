import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemSettings {
  static Future<void> lockRotation() {
    return SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
  }

  static Future<void> makeTransparentAppBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Future.value();
  }
}
