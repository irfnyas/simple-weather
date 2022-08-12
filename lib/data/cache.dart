import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_weather/domain/util/constant.dart';

Future<dynamic> cacheWrite(String key, dynamic value) async {
  final pref = await SharedPreferences.getInstance();

  if (value is int) {
    pref.setInt(key, value);
  } else if (value is double) {
    pref.setDouble(key, value);
  } else if (value is bool) {
    pref.setBool(key, value);
  } else if (value is List) {
    pref.setStringList(key, value.map((e) => '$e').toList());
  } else {
    pref.setString(key, '$value');
  }

  return value;
}

Future<dynamic>? cacheRead(String key) async {
  final pref = await SharedPreferences.getInstance();

  return pref.get(key);
}

Future<void> cacheRemove(String key) async {
  final pref = await SharedPreferences.getInstance();
  pref.remove(key);
}

Future<void> cacheClear() async {
  final pref = await SharedPreferences.getInstance();
  pref.clear();
}

Future<bool> cacheIsLoggedIn() async {
  return await cacheRead(cacheName) != null;
}
