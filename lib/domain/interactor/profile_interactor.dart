import 'package:flutter/cupertino.dart';
import 'package:simple_weather/data/cache.dart' as cache;
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
    isLoggedIn.value = await cache.isLoggedIn();

    if (!isLoggedIn.value) {
      router.go(routeProfile);
    } else {
      name.value = await cache.read(prefName) ?? '';
      prov.value = await cache.read(prefProvId) ?? '';
      city.value = await cache.read(prefCityId) ?? '';
      cityName.value = await cache.read(prefCityName) ?? '';
    }
  }

  Future<void> save(ProfileModel profile) async {
    name.value = profile.name.isNotEmpty
        ? await cache.write(prefName, profile.name)
        : name.value;

    prov.value = profile.prov?.id != null
        ? await cache.write(prefProvId, profile.prov?.id)
        : prov.value;

    city.value = profile.city?.id != null
        ? await cache.write(prefCityId, profile.city?.id)
        : city.value;

    cityName.value = profile.city?.name != null
        ? await cache.write(prefCityName, profile.city?.name)
        : cityName.value;

    profile.city?.lat != null
        ? await cache.write(prefCityLat, profile.city?.lat)
        : null;

    profile.city?.lng != null
        ? await cache.write(prefCityLng, profile.city?.lng)
        : null;
  }
}
