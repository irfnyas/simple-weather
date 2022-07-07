import 'package:flutter/cupertino.dart';
import 'package:simple_weather/data/cache.dart';
import 'package:simple_weather/domain/model/profile_model.dart';
import 'package:simple_weather/domain/util/constant.dart';

class ProfileInteractor {
  final name = ValueNotifier('');
  final prov = ValueNotifier('');
  final city = ValueNotifier('');
  final cityName = ValueNotifier('');
  final isLoggedIn = ValueNotifier(false);

  Future<void> init() async {
    isLoggedIn.value = await Cache.isLoggedIn();
    if (isLoggedIn.value) {
      name.value = await Cache.read(prefName) ?? '';
      prov.value = await Cache.read(prefProvId) ?? '';
      city.value = await Cache.read(prefCityId) ?? '';
      cityName.value = await Cache.read(prefCityName) ?? '';
    }
  }

  Future<void> save(ProfileModel profile) async {
    name.value = profile.name.isNotEmpty
        ? await Cache.write(prefName, profile.name)
        : name.value;

    prov.value = profile.prov?.id != null
        ? await Cache.write(prefProvId, profile.prov?.id)
        : prov.value;

    city.value = profile.city?.id != null
        ? await Cache.write(prefCityId, profile.city?.id)
        : city.value;

    cityName.value = profile.city?.name != null
        ? await Cache.write(prefCityName, profile.city?.name)
        : cityName.value;

    profile.city?.lat != null
        ? await Cache.write(prefCityLat, profile.city?.lat)
        : null;

    profile.city?.lng != null
        ? await Cache.write(prefCityLng, profile.city?.lng)
        : null;
  }
}
