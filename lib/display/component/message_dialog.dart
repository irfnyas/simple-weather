import 'package:flutter/material.dart';
import 'package:simple_weather/domain/util/constant.dart';

class MessageDialog extends StatelessWidget {
  const MessageDialog({Key? key, required this.title, required this.content})
      : super(key: key);
  final String? title;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: title != null ? Text(title ?? '') : null,
        content: content != null ? Text(content ?? '') : null,
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(textOk))
        ]);
  }
}
