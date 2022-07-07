import 'package:flutter/material.dart';
import 'package:simple_weather/display/component/exit_dialog.dart';
import 'package:simple_weather/display/component/message_dialog.dart';
import 'package:simple_weather/domain/util/router.dart';

class DialogManager {
  static showMessage(String? title, String? content) {
    showDialog(
        context: router.navigator!.context,
        builder: (BuildContext context) =>
            MessageDialog(title: title, content: content));
  }

  static showExit() {
    showDialog(
        context: router.navigator!.context,
        builder: (BuildContext context) => const ExitDialog());
  }
}
