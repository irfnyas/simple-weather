import 'package:flutter/material.dart';
import 'package:simple_weather/display/component/exit_dialog.dart';
import 'package:simple_weather/display/component/message_dialog.dart';
import 'package:simple_weather/main.dart';

class DialogManager {
  static showMessage(String? title, String? content) {
    showDialog(
        context: navigatorKey.currentState!.overlay!.context,
        builder: (BuildContext context) =>
            MessageDialog(title: title, content: content));
  }

  static showExit() {
    showDialog(
        context: navigatorKey.currentState!.overlay!.context,
        builder: (BuildContext context) => const ExitDialog());
  }
}
