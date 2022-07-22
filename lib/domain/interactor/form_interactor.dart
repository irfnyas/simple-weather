import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simple_weather/data/api.dart';
import 'package:simple_weather/data/cache.dart';
import 'package:simple_weather/domain/interactor/profile_interactor.dart';
import 'package:simple_weather/domain/model/city_model.dart';
import 'package:simple_weather/domain/model/profile_model.dart';
import 'package:simple_weather/domain/model/province_model.dart';
import 'package:simple_weather/domain/util/constant.dart';
import 'package:simple_weather/domain/util/service_locator.dart';
import 'package:collection/collection.dart';

class FormInteractor {
  final _profile = sl<ProfileInteractor>();

  final key = GlobalKey<FormState>();
  final nameNode = FocusNode();
  final provNode = FocusNode();
  final cityNode = FocusNode();
  final nameController = TextEditingController();

  final provId = ValueNotifier('');
  final cityId = ValueNotifier('');
  final provinces = ValueNotifier(<ProvinceModel>[]);
  final cities = ValueNotifier(<CityModel>[]);

  Future<void> init() async {
    nameController.text = _profile.name.value;
    provinces.value = [];
    cities.value = [];
    provId.value = await cacheRead(cacheProvId) ?? '';
    cityId.value = await cacheRead(cacheCityId) ?? '';
    await getProvincesData();
  }

  Future<void> getProvincesData() async {
    final list = <ProvinceModel>[];
    final res = await apiGetProvinces();

    if (res?.statusCode == 200) {
      final data = jsonDecode(res?.body ?? '');
      for (final json in data) {
        final model = ProvinceModel.fromJson(json);
        list.add(model);
      }
    }

    if (list.isNotEmpty && provId.value.isNotEmpty) {
      final selected = list.firstWhereOrNull((item) => item.id == provId.value);
      setProvince(selected);
    }

    provinces.value = list;
  }

  void setProvince(ProvinceModel? item) {
    provId.value = item?.id ?? '';
    cities.value = [];
    getCitiesData(provId.value);
  }

  Future<void> getCitiesData(String provId) async {
    final list = <CityModel>[];
    final res = await apiGetCities(provId);

    if (res?.statusCode == 200) {
      final data = jsonDecode(res?.body ?? '');
      for (final json in data) {
        final model = CityModel.fromJson(json);
        list.add(model);
      }
    }

    if (list.isNotEmpty && cityId.value.isNotEmpty) {
      final selected = list.firstWhereOrNull((item) => item.id == cityId.value);
      setCity(selected);
    }

    cities.value = list;
  }

  void setCity(CityModel? item) {
    cityId.value = item?.id ?? '';
  }

  Future<bool> submit() async {
    final isValid = key.currentState?.validate() == true;

    if (!isValid) {
      nameController.text.isEmpty == true
          ? nameNode.requestFocus()
          : nameNode.nextFocus();
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      await Future.delayed(const Duration(milliseconds: 500));

      final name = nameController.text.trim().toUpperCase();
      final prov =
          provinces.value.firstWhereOrNull((item) => item.id == provId.value) ??
              provinces.value[0];
      final city =
          cities.value.firstWhereOrNull((item) => item.id == cityId.value) ??
              cities.value[0];

      await _profile.save(ProfileModel(
        name: name,
        prov: prov,
        city: city,
      ));
    }

    return isValid;
  }

  ProvinceModel? selectedItemProvField() {
    return provinces.value.isNotEmpty
        ? provinces.value.firstWhereOrNull((item) => item.id == provId.value)
        : null;
  }

  void onChangedProvField(ProvinceModel? item) {
    if (item != null) setProvince(item);
  }

  CityModel? selectedItemCityField() {
    if (cities.value.isNotEmpty) {
      return cityId.value != ''
          ? cities.value.firstWhereOrNull((item) => item.id == cityId.value) ??
              cities.value[0]
          : cities.value[0];
    }
    return null;
  }

  void onChangedCityField(CityModel? item) {
    if (item != null) setCity(item);
  }
}
