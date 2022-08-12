import 'package:flutter/material.dart';

class NameTextWidget extends StatelessWidget {
  const NameTextWidget({Key? key, required this.value}) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: Theme.of(context)
          .textTheme
          .subtitle2
          ?.copyWith(fontWeight: FontWeight.normal),
    );
  }
}
