import 'package:flutter/material.dart';
import 'package:simple_weather/domain/model/weather_model.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({Key? key, required this.weather}) : super(key: key);
  final WeatherModel weather;

  @override
  Widget build(BuildContext context) {
    final dateWidget = Text(weather.date,
        style: Theme.of(context)
            .textTheme
            .subtitle2
            ?.copyWith(fontWeight: FontWeight.normal));

    final degreesWidget = Row(children: [
      Text('${weather.degrees}°', style: Theme.of(context).textTheme.headline6),
      Image.network(weather.icon, height: 32)
    ]);

    final conditionWidget = Text(weather.condition,
        maxLines: 1,
        style: Theme.of(context).textTheme.caption?.copyWith(
            color: Colors.grey.shade900, overflow: TextOverflow.ellipsis));

    return Card(
        elevation: 0,
        color: Colors.transparent,
        child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  dateWidget,
                  const Spacer(flex: 2),
                  degreesWidget,
                  const Spacer(),
                  conditionWidget
                ])));
  }
}
