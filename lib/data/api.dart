import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:simple_weather/domain/util/api_middleware.dart';
import 'package:simple_weather/domain/util/constant.dart';

Future<Response?> apiGetProvinces() => getr('$urlWilayah/provinces.json');

Future<Response?> apiGetCities(String provinceId) =>
    getr('$urlWilayah/regencies/$provinceId.json');

Future<Response?> apiGetForecast(String lat, String lng, String units) =>
    getr(urlOpenWeather, queries: {
      'appid': dotenv.get('OPEN_WEATHER_KEY', fallback: ''),
      'lat': lat,
      'lon': lng,
      'units': units,
    });
