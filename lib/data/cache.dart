import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_weather/domain/util/constant.dart';

class Cache {
  static Future<dynamic> write(String key, dynamic value) async {
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

  static Future<dynamic>? read(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.get(key);
  }

  static Future<void> remove(String key) async {
    final pref = await SharedPreferences.getInstance();
    pref.remove(key);
  }

  static Future<void> clear() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  static Future<bool> isLoggedIn() async {
    return await read(prefName) != null;
  }
}
