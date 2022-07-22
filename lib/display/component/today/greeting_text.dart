import 'package:flutter/material.dart';

class GreetingTextWidget extends StatelessWidget {
  const GreetingTextWidget({Key? key, required this.value}) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(value, style: Theme.of(context).textTheme.subtitle2);
  }
}
