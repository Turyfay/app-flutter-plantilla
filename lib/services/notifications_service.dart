import 'package:flutter/material.dart';

class NotificationService {
  static late GlobalKey<ScaffoldMessengerState> meesageKey =
      GlobalKey<ScaffoldMessengerState>();

  static void showMessage(String message, [MaterialColor? color]) {
    meesageKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color ?? Colors.red,
    ));
  }
}
