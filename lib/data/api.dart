import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:simple_weather/domain/util/api_middleware.dart';
import 'package:simple_weather/domain/util/constant.dart';

class Api {
  static Future<Response?> getr(
      String url, Map<String, String>? queries) async {
    Response? res;
    try {
      res = ApiMiddleware.check(
          await get(Uri.parse(url).replace(queryParameters: queries)));
    } catch (e) {
      ApiMiddleware.error(e);
    }

    return res;
  }

  static Future<Response?> getProvinces() =>
      getr('$wilayahUrl/provinces.json', null);

  static Future<Response?> getCities(String provinceId) =>
      getr('$wilayahUrl/regencies/$provinceId.json', null);

  static Future<Response?> getForecast(String lat, String lng) =>
      getr(openWeatherUrl, {
        'appid': dotenv.get('OPEN_WEATHER_KEY', fallback: ''),
        'lat': lat,
        'lon': lng,
        'units': 'metric'
      });
}
