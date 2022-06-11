import 'package:flutter/material.dart';
import 'package:weather_flutter/domain/model/weather_model.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({Key? key, required this.weather}) : super(key: key);
  final WeatherModel weather;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(weather.date,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(fontWeight: FontWeight.normal)),
              const Spacer(flex: 2),
              Row(
                children: [
                  Text('${weather.degrees}°',
                      style: Theme.of(context).textTheme.headline6),
                  Image.network(
                    weather.icon,
                    height: 32,
                  ),
                ],
              ),
              const Spacer(),
              Text(weather.condition,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                      color: Colors.grey.shade900,
                      overflow: TextOverflow.ellipsis))
            ]),
      ),
    );
  }
}
