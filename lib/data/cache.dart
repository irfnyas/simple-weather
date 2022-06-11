import 'package:get_storage/get_storage.dart';
import 'package:weather_flutter/domain/util/constant.dart';

class Cache {
  dynamic read(String pref) {
    return GetStorage().read(pref);
  }

  dynamic write(String pref, dynamic value) {
    final newVal = value.toUpperCase().trim();
    GetStorage().write(pref, newVal);
    return newVal;
  }

  bool isLoggedIn() {
    return read(prefName) != null;
  }
}
