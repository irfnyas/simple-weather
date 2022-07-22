import 'package:flutter/material.dart';

class DegreesText extends StatelessWidget {
  const DegreesText({Key? key, required this.value}) : super(key: key);

  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('°',
          style: Theme.of(context).textTheme.headline1?.copyWith(
              fontWeight: FontWeight.normal, color: Colors.transparent)),
      Text(value,
          style: Theme.of(context).textTheme.headline1?.copyWith(
              fontWeight: FontWeight.normal, color: Colors.grey.shade900)),
      Text('°',
          style: Theme.of(context).textTheme.headline1?.copyWith(
              fontWeight: FontWeight.normal, color: Colors.grey.shade900))
    ]);
  }
}
