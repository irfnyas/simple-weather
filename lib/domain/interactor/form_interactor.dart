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
    provId.value = await Cache.read(prefProvId) ?? '';
    cityId.value = await Cache.read(prefCityId) ?? '';
    await getProvincesData();
  }

  Future<void> getProvincesData() async {
    final _list = <ProvinceModel>[];

    var _res = await Api.getProvinces();
    if (_res?.statusCode == 200) {
      final data = jsonDecode(_res?.body ?? '');
      for (var json in data) {
        final model = ProvinceModel.fromJson(json);
        _list.add(model);
      }
    }

    if (_list.isNotEmpty && provId.value.isNotEmpty) {
      final _selected =
          _list.firstWhereOrNull((item) => item.id == provId.value);
      setProvince(_selected);
    }

    provinces.value = _list;
  }

  void setProvince(ProvinceModel? item) {
    provId.value = item?.id ?? '';
    cities.value = [];
    getCitiesData(provId.value);
  }

  Future<void> getCitiesData(String provId) async {
    final _list = <CityModel>[];

    var _res = await Api.getCities(provId);
    if (_res?.statusCode == 200) {
      final data = jsonDecode(_res?.body ?? '');
      for (var json in data) {
        final model = CityModel.fromJson(json);
        _list.add(model);
      }
    }

    if (_list.isNotEmpty && cityId.value.isNotEmpty) {
      final _selected =
          _list.firstWhereOrNull((item) => item.id == cityId.value);
      setCity(_selected);
    }

    cities.value = _list;
  }

  void setCity(CityModel? item) {
    cityId.value = item?.id ?? '';
  }

  Future<bool> submit() async {
    final _isValid = key.currentState?.validate() == true;

    if (!_isValid) {
      nameController.text.isEmpty == true ? nameNode.requestFocus() : null;
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      await Future.delayed(const Duration(milliseconds: 500));

      final _name = nameController.text.trim().toUpperCase();
      final _prov =
          provinces.value.firstWhereOrNull((item) => item.id == provId.value);
      final _city =
          cities.value.firstWhereOrNull((item) => item.id == cityId.value);

      await _profile.save(ProfileModel(
        name: _name,
        prov: _prov,
        city: _city,
      ));
    }

    return _isValid;
  }
}
