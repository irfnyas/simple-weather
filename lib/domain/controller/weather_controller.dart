import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_flutter/data/api.dart';
import 'package:weather_flutter/data/cache.dart';
import 'package:weather_flutter/domain/enum/time_enum.dart';
import 'package:weather_flutter/domain/model/weather_model.dart';
import 'package:weather_flutter/domain/util/constant.dart';

class WeatherController extends GetxController {
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  final greeting = ''.obs;
  final weathers = [].obs;

  @override
  void onReady() {
    super.onReady();
    greeting.value = _getGreeting();
  }

  String _getGreeting() {
    final _currentHour = DateTime.now().hour;
    if (_currentHour >= 5 && _currentHour < 12) {
      return Time.morning.greet;
    } else if (_currentHour >= 12 && _currentHour < 18) {
      return Time.afternoon.greet;
    } else {
      return Time.night.greet;
    }
  }

  Future<void> getForecastData() async {
    final _lat = Cache().read(prefCityLat);
    final _lng = Cache().read(prefCityLng);

    if (_lat != null && _lng != null) {
      final _res = await Api().getForecast(_lat, _lng);

      if (_res?.isOk == true) {
        weathers.clear();
        final data = _res?.body;
        final list = data['list'];

        for (var item in list) {
          int hour = item['dt_txt'] != null ? simpleHour(item['dt_txt']) : 0;

          String date =
              item['dt_txt'] != null ? simpleDate(item['dt_txt']) : '';

          String degrees =
              rounded(item['main'] != null ? item['main']['temp'] ?? 0 : 0);

          String icon =
              item['weather'] != null ? item['weather'][0]['icon'] ?? '' : '';

          String condition = item['weather'] != null
              ? item['weather'][0]['description'] ?? ''
              : '';

          if (weathers.isEmpty || hour == 12 || item == list.last) {
            final model = WeatherModel(
              condition: condition.toUpperCase(),
              date: date.toUpperCase(),
              degrees: degrees,
              icon: 'http://openweathermap.org/img/wn/$icon.png',
            );
            weathers.add(model);
          }
        }
      }
    }
  }

  String simpleDate(String date) {
    return DateFormat('EEE dd').format(DateTime.parse(date));
  }

  int simpleHour(String date) {
    return int.tryParse(DateFormat('H').format(DateTime.parse(date))) ?? 0;
  }

  String rounded(num degrees) {
    return '${degrees.round()}';
  }
}
