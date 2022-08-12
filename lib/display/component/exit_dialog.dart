import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_weather/domain/util/constant.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(title: const Text(textExitTitle), actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(textBack, style: TextStyle(color: Colors.grey.shade700)),
      ),
      TextButton(
        onPressed: () => SystemNavigator.pop(),
        child: const Text(textExit),
      ),
    ]);
  }
}
