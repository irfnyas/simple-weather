import 'package:flutter/material.dart';

class ConditionTextWidget extends StatelessWidget {
  const ConditionTextWidget({Key? key, required this.value}) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(value, style: Theme.of(context).textTheme.overline);
  }
}
