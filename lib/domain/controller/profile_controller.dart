import 'package:get/get.dart';
import 'package:weather_flutter/data/cache.dart';
import 'package:weather_flutter/display/screen/profile_screen.dart';
import 'package:weather_flutter/domain/model/profile_model.dart';
import 'package:weather_flutter/domain/util/constant.dart';

class ProfileController extends GetxController {
  final name = ''.obs;
  final prov = ''.obs;
  final city = ''.obs;
  final cityName = ''.obs;

  @override
  void onReady() {
    super.onReady();
    if (Cache().isLoggedIn()) {
      name.value = Cache().read(prefName) ?? '';
      prov.value = Cache().read(prefProvId) ?? '';
      city.value = Cache().read(prefCityId) ?? '';
      cityName.value = Cache().read(prefCityName) ?? '';
    } else {
      Get.off(() => const ProfileScreen());
    }
  }

  void save(ProfileModel profile) {
    name.value = profile.name.isNotEmpty
        ? Cache().write(prefName, profile.name)
        : name.value;

    prov.value = profile.prov?.id != null
        ? Cache().write(prefProvId, profile.prov?.id)
        : prov.value;

    city.value = profile.city?.id != null
        ? Cache().write(prefCityId, profile.city?.id)
        : city.value;

    cityName.value = profile.city?.name != null
        ? Cache().write(prefCityName, profile.city?.name)
        : cityName.value;

    profile.city?.lat != null
        ? Cache().write(prefCityLat, profile.city?.lat)
        : null;

    profile.city?.lng != null
        ? Cache().write(prefCityLng, profile.city?.lng)
        : null;
  }
}
