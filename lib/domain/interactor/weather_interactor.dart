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
    greeting.value = _greeting();
  }

  Future<void> getForecastData() async {
    final _lat = await Cache.read(prefCityLat);
    final _lng = await Cache.read(prefCityLng);

    if (_lat != null && _lng != null) {
      final _list = <WeatherModel>[];
      final _res = await Api.getForecast(_lat, _lng);

      if (_res?.statusCode == 200) {
        weathers.value.clear();
        final _data = jsonDecode(_res?.body ?? '');
        final _dataList = _data['list'];

        for (var _item in _dataList) {
          int _hour =
              _item['dt_txt'] != null ? _simpleHour(_item['dt_txt']) : 0;

          String _date =
              _item['dt_txt'] != null ? _simpleDate(_item['dt_txt']) : '';

          String _degrees =
              _rounded(_item['main'] != null ? _item['main']['temp'] ?? 0 : 0);

          String _icon =
              _item['weather'] != null ? '${_item['weather'][0]['icon']}' : '';

          String _condition = _item['weather'] != null
              ? '${_item['weather'][0]['description']}'.toUpperCase()
              : '';

          final _isFirstOrLast = _list.isEmpty || _item == _dataList.last;
          final _isMidDay =
              _list.isNotEmpty && _date != _list[0].date && _hour == 12;

          if (_isFirstOrLast || _isMidDay) {
            final _model = WeatherModel(
              condition: _condition,
              date: _date,
              degrees: _degrees,
              icon: 'http://openweathermap.org/img/wn/$_icon.png',
            );
            _list.add(_model);
          }
        }
      }

      weathers.value = _list;
    }
  }

  static String _greeting() {
    final _currentHour = DateTime.now().hour;

    if (_currentHour >= 5 && _currentHour < 12) {
      return Time.morning.greet;
    } else if (_currentHour >= 12 && _currentHour < 18) {
      return Time.afternoon.greet;
    } else {
      return Time.night.greet;
    }
  }

  static String _simpleDate(String date) {
    return DateFormat('EEE dd').format(DateTime.parse(date)).toUpperCase();
  }

  static int _simpleHour(String date) {
    return int.tryParse(DateFormat('H').format(DateTime.parse(date))) ?? 0;
  }

  static String _rounded(num degrees) {
    return '${degrees.round()}';
  }
}
