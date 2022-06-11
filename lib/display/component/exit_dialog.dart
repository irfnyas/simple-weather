import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Exit App?'),
      actions: [
        TextButton(
          child: Text(
            'BACK',
            style: TextStyle(color: Colors.grey.shade700),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
            child: const Text('EXIT'), onPressed: () => SystemNavigator.pop()),
      ],
    );
  }
}
