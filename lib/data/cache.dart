import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_weather/domain/util/constant.dart';

class Cache {
  static Future<dynamic> write(String key, dynamic value) async {
    final _pref = await SharedPreferences.getInstance();

    if (value is int) {
      _pref.setInt(key, value);
    } else if (value is double) {
      _pref.setDouble(key, value);
    } else if (value is bool) {
      _pref.setBool(key, value);
    } else if (value is List) {
      _pref.setStringList(key, value.map((e) => '$e').toList());
    } else {
      _pref.setString(key, '$value');
    }

    return value;
  }

  static Future<dynamic>? read(String key) async {
    final _pref = await SharedPreferences.getInstance();
    return _pref.get(key);
  }

  static Future<void> remove(String key) async {
    final _pref = await SharedPreferences.getInstance();
    _pref.remove(key);
  }

  static Future<void> clear() async {
    final _pref = await SharedPreferences.getInstance();
    _pref.clear();
  }

  static Future<bool> isLoggedIn() async {
    return await read(prefName) != null;
  }
}
