import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_weather/display/component/profile_dropdown_field.dart';
import 'package:simple_weather/display/component/profile_form_field.dart';
import 'package:simple_weather/domain/model/city_model.dart';
import 'package:simple_weather/domain/model/province_model.dart';
import 'package:simple_weather/domain/util/constant.dart';
import 'package:simple_weather/domain/util/service_locator.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: profile.isLoggedIn.value,
            actions: [
              TextButton(
                  child: const Text(textSave),
                  onPressed: () async =>
                      await form.submit() ? context.go(routeToday) : null),
            ]),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
                key: form.key,
                child: Column(children: [
                  ProfileFormField(
                      controller: form.nameController,
                      node: form.nameNode,
                      label: textLabelName,
                      hint: textHintName),
                  ValueListenableBuilder<List<ProvinceModel>>(
                      valueListenable: form.provinces,
                      builder: (_, value, __) {
                        return ProfileDropdownField(
                            list: value,
                            labelText: textLabelProv,
                            errorText: textErrorEmptyProv,
                            isLoading: value.isEmpty,
                            selectedItem: form.selectedItemProvField(),
                            onChanged: (item) => form.onChangedProvField(item));
                      }),
                  ValueListenableBuilder<List<CityModel>>(
                      valueListenable: form.cities,
                      builder: (_, value, __) {
                        return ProfileDropdownField(
                            list: value,
                            labelText: textLabelCity,
                            errorText: textErrorEmptyCity,
                            isLoading: value.isEmpty && form.provId.value != '',
                            selectedItem: form.selectedItemCityField(),
                            onChanged: (item) => form.onChangedCityField(item));
                      })
                ]))));
  }
}
