import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemSettings {
  static Future<void> lockRotation() {
    return SystemChrome.setPreferredOrientations([
      if (kIsWeb) ...{
        DeviceOrientation.landscapeLeft,
      } else ...{
        DeviceOrientation.portraitUp,
      }
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
