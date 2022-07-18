import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_weather/display/component/profile_dropdown_field.dart';
import 'package:simple_weather/display/component/profile_form_field.dart';
import 'package:simple_weather/domain/interactor/form_interactor.dart';
import 'package:simple_weather/domain/interactor/profile_interactor.dart';
import 'package:simple_weather/domain/model/city_model.dart';
import 'package:simple_weather/domain/model/province_model.dart';
import 'package:simple_weather/domain/util/constant.dart';
import 'package:simple_weather/domain/util/dialog_manager.dart';
import 'package:simple_weather/domain/util/service_locator.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final form = sl<FormInteractor>();
    final profile = sl<ProfileInteractor>();

    form.init();

    return WillPopScope(
        onWillPop: () async {
          if (!profile.isLoggedIn.value) {
            DialogManager.showExit();
          }
          return profile.isLoggedIn.value;
        },
        child: Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: profile.isLoggedIn.value,
                actions: [
                  TextButton(
                      child: const Text(textSave),
                      onPressed: () async =>
                          await form.submit() ? context.go(routeToday) : null),
                ]),
            body: Container(
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
                                onChanged: (item) =>
                                    form.onChangedProvField(item));
                          }),
                      ValueListenableBuilder<List<CityModel>>(
                          valueListenable: form.cities,
                          builder: (_, value, __) {
                            return ProfileDropdownField(
                                list: value,
                                labelText: textLabelCity,
                                errorText: textErrorEmptyCity,
                                isLoading:
                                    value.isEmpty && form.provId.value != '',
                                selectedItem: form.selectedItemCityField(),
                                onChanged: (item) =>
                                    form.onChangedCityField(item));
                          })
                    ])))));
  }
}
