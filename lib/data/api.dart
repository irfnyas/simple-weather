import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:simple_weather/domain/util/api_middleware.dart';
import 'package:simple_weather/domain/util/constant.dart';

Future<Response?> getr(String url, Map<String, String>? queries) async {
  Response? res;
  try {
    final uri = Uri.parse(url).replace(queryParameters: queries);
    final req = await get(uri);
    res = await midCheck(req);
  } catch (e) {
    await midError(e);
  }
  return res;
}

Future<Response?> getProvinces() => getr('$wilayahUrl/provinces.json', null);

Future<Response?> getCities(String provinceId) =>
    getr('$wilayahUrl/regencies/$provinceId.json', null);

Future<Response?> getForecast(String lat, String lng) => getr(openWeatherUrl, {
      'appid': dotenv.get('OPEN_WEATHER_KEY', fallback: ''),
      'lat': lat,
      'lon': lng,
      'units': 'metric'
    });
