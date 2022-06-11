import 'package:get/get.dart';
import 'package:weather_flutter/domain/util/api_middleware.dart';
import 'package:weather_flutter/domain/util/constant.dart';
import 'package:weather_flutter/domain/util/secret.dart';

class Api extends GetConnect {
  Future<Response?> getProvinces() =>
      ApiMiddleware().gets('$wilayahUrl/provinces.json', null);

  Future<Response?> getCities(String provinceId) =>
      ApiMiddleware().gets('$wilayahUrl/regencies/$provinceId.json', null);

  Future<Response?> getForecast(String lat, String lng) => ApiMiddleware().gets(
      openWeatherUrl,
      {'appid': openWeatherKey, 'lat': lat, 'lon': lng, 'units': 'metric'});
}
