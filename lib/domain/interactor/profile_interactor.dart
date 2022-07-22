import 'package:flutter/cupertino.dart';
import 'package:simple_weather/data/cache.dart';
import 'package:simple_weather/domain/model/profile_model.dart';
import 'package:simple_weather/domain/util/constant.dart';
import 'package:simple_weather/domain/util/router.dart';

class ProfileInteractor {
  final name = ValueNotifier('');
  final prov = ValueNotifier('');
  final city = ValueNotifier('');
  final cityName = ValueNotifier('');
  final isLoggedIn = ValueNotifier(false);

  Future<void> init() async {
    isLoggedIn.value = await cacheIsLoggedIn();

    if (!isLoggedIn.value) {
      router.go(routeProfile);
    } else {
      name.value = await cacheRead(cacheName) ?? '';
      prov.value = await cacheRead(cacheProvId) ?? '';
      city.value = await cacheRead(cacheCityId) ?? '';
      cityName.value = await cacheRead(cacheCityName) ?? '';
    }
  }

  Future<void> save(ProfileModel profile) async {
    name.value = profile.name.isNotEmpty
        ? await cacheWrite(cacheName, profile.name)
        : name.value;

    prov.value = profile.prov?.id != null
        ? await cacheWrite(cacheProvId, profile.prov?.id)
        : prov.value;

    city.value = profile.city?.id != null
        ? await cacheWrite(cacheCityId, profile.city?.id)
        : city.value;

    cityName.value = profile.city?.name != null
        ? await cacheWrite(cacheCityName, profile.city?.name)
        : cityName.value;

    profile.city?.lat != null
        ? await cacheWrite(cacheCityLat, profile.city?.lat)
        : null;

    profile.city?.lng != null
        ? await cacheWrite(cacheCityLng, profile.city?.lng)
        : null;
  }
}
