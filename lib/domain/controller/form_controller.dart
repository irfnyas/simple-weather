import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_flutter/data/cache.dart';
import 'package:weather_flutter/data/api.dart';
import 'package:weather_flutter/display/screen/today_screen.dart';
import 'package:weather_flutter/domain/controller/profile_controller.dart';
import 'package:weather_flutter/domain/model/city_model.dart';
import 'package:weather_flutter/domain/model/profile_model.dart';
import 'package:weather_flutter/domain/model/province_model.dart';
import 'package:weather_flutter/domain/util/constant.dart';

class FormController extends GetxController {
  final _profile = Get.isRegistered<ProfileController>()
      ? Get.find<ProfileController>()
      : Get.put(ProfileController());

  final key = GlobalKey<FormState>();

  final nameNode = FocusNode();
  final provNode = FocusNode();
  final cityNode = FocusNode();

  final nameController = TextEditingController();

  final provId = ''.obs;
  final cityId = ''.obs;
  final provinces = <ProvinceModel>[].obs;
  final cities = <CityModel>[].obs;

  @override
  void onInit() async {
    super.onInit();

    nameController.text = _profile.name.value;
    provId.value = Cache().read(prefProvId) ?? '';
    cityId.value = Cache().read(prefCityId) ?? '';

    getProvincesData();
  }

  Future<void> getProvincesData() async {
    var _res = await Api().getProvinces();

    if (_res?.isOk == true) {
      final data = _res?.body;
      for (var json in data) {
        final model = ProvinceModel.fromJson(json);
        provinces.add(model);
      }
    }

    if (provinces.isNotEmpty && provId.value.isNotEmpty) {
      setProvince(
          provinces.firstWhereOrNull((item) => item.id == provId.value));
    }
  }

  void setProvince(ProvinceModel? item) {
    cities.clear();
    provId.value = item?.id ?? '';
    getRegenciesData(provId.value);
  }

  Future<void> getRegenciesData(String provId) async {
    var _res = await Api().getCities(provId);

    if (_res?.isOk == true) {
      final data = _res?.body;
      for (var json in data) {
        final model = CityModel.fromJson(json);
        cities.add(model);
      }
    }

    if (cities.isNotEmpty && cityId.value.isNotEmpty) {
      setCity(cities.firstWhereOrNull((item) => item.id == cityId.value));
    }
  }

  void setCity(CityModel? item) {
    cityId.value = item?.id ?? '';
  }

  void submit() {
    if (key.currentState?.validate() ?? false) {
      FocusManager.instance.primaryFocus?.unfocus();
      Future.delayed(const Duration(milliseconds: 500), () {
        _profile.save(ProfileModel(
          name: nameController.text,
          prov: provinces.firstWhereOrNull((item) => item.id == provId.value),
          city: cities.firstWhereOrNull((item) => item.id == cityId.value),
        ));

        Get.routing.route?.isFirst == true
            ? Get.off(() => const TodayScreen())
            : Get.back();
      });
    } else {
      nameController.text.isBlank == true ? nameNode.requestFocus() : null;
    }
  }

  bool isLoggedIn() {
    return Cache().isLoggedIn();
  }
}
