import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_weather/data/api.dart';
import 'package:simple_weather/data/cache.dart';
import 'package:simple_weather/domain/enum/time_enum.dart';
import 'package:simple_weather/domain/model/weather_model.dart';
import 'package:simple_weather/domain/util/constant.dart';

class WeatherInteractor {
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final greeting = ValueNotifier('');
  final weathers = ValueNotifier(<WeatherModel>[]);

  void init() {
    greeting.value = greetingText();
    getForecastData();
  }

  Future<void> getForecastData() async {
    final lat = await cacheRead(cacheCityLat);
    final lng = await cacheRead(cacheCityLng);

    if (lat != null && lng != null) {
      final list = <WeatherModel>[];
      final res = await apiGetForecast(lat, lng);

      if (res?.statusCode == 200) {
        weathers.value.clear();
        final data = jsonDecode(res?.body ?? '');
        final dataList = data['list'];

        for (final item in dataList) {
          int hour = item['dt_txt'] != null ? simpleHour(item['dt_txt']) : 0;

          String date =
              item['dt_txt'] != null ? simpleDate(item['dt_txt']) : '';

          String degrees =
              rounded(item['main'] != null ? item['main']['temp'] ?? 0 : 0);

          String icon =
              item['weather'] != null ? '${item['weather'][0]['icon']}' : '';

          String condition = item['weather'] != null
              ? '${item['weather'][0]['description']}'.toUpperCase()
              : '';

          final isFirst = list.isEmpty;
          final isMidDay =
              list.isNotEmpty && date != list[0].date && hour == 12;
          final isLast = item == dataList.last;

          if (isFirst || isMidDay || isLast) {
            final isSameDayAsBefore =
                !isFirst ? date == list[list.length - 1].date : false;
            final dateText =
                isLast && isSameDayAsBefore ? '$date ($hour:00)' : date;

            final model = WeatherModel(
              condition: condition,
              date: dateText,
              degrees: degrees,
              icon: 'http://openweathermap.org/img/wn/$icon.png',
            );

            list.add(model);
          }
        }
      }

      weathers.value = list;
    }
  }

  String greetingText() {
    final currentHour = DateTime.now().hour;

    if (currentHour >= 6 && currentHour < 12) {
      return Time.morning.greet;
    } else if (currentHour >= 12 && currentHour < 16) {
      return Time.afternoon.greet;
    } else if (currentHour >= 16 && currentHour < 18) {
      return Time.evening.greet;
    } else {
      return Time.night.greet;
    }
  }

  String simpleDate(String date) {
    return DateFormat('EEE dd').format(DateTime.parse(date)).toUpperCase();
  }

  int simpleHour(String date) {
    return int.tryParse(DateFormat('H').format(DateTime.parse(date))) ?? 0;
  }

  String rounded(num degrees) {
    return '${degrees.round()}';
  }
}
