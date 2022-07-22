import 'package:flutter/material.dart';
import 'package:simple_weather/display/component/weather_card.dart';
import 'package:simple_weather/domain/model/weather_model.dart';

class ForecastList extends StatelessWidget {
  const ForecastList({Key? key, required this.value}) : super(key: key);

  final List<WeatherModel> value;

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: 0.92,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            primary: false,
            shrinkWrap: true,
            itemCount: 5,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (_, i) {
              return value.isNotEmpty
                  ? WeatherCard(weather: value[i + 1])
                  : const SizedBox();
            }));
  }
}
