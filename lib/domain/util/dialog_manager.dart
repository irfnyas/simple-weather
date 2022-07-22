import 'package:flutter/material.dart';
import 'package:simple_weather/display/component/exit_dialog.dart';
import 'package:simple_weather/display/component/message_dialog.dart';
import 'package:simple_weather/domain/util/router.dart';

Future<dynamic> showMessageDialog(String? title, String? content) {
  return showDialog(
      context: router.navigator!.context,
      builder: (BuildContext context) =>
          MessageDialog(title: title, content: content));
}

Future<dynamic> showExitDialog() {
  return showDialog(
      context: router.navigator!.context,
      builder: (BuildContext context) => const ExitDialog());
}
