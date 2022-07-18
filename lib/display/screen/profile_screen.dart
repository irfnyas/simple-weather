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
    final _form = sl<FormInteractor>();
    final _profile = sl<ProfileInteractor>();

    _form.init();

    return WillPopScope(
        onWillPop: () async {
          if (!_profile.isLoggedIn.value) {
            DialogManager.showExit();
          }
          return _profile.isLoggedIn.value;
        },
        child: Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: _profile.isLoggedIn.value,
                actions: [
                  TextButton(
                      child: const Text(textSave),
                      onPressed: () async =>
                          await _form.submit() ? context.go(routeToday) : null),
                ]),
            body: Container(
                padding: const EdgeInsets.all(16),
                child: Form(
                    key: _form.key,
                    child: Column(children: [
                      ProfileFormField(
                          controller: _form.nameController,
                          node: _form.nameNode,
                          label: textLabelName,
                          hint: textHintName),
                      ValueListenableBuilder<List<ProvinceModel>>(
                          valueListenable: _form.provinces,
                          builder: (_, value, __) {
                            return ProfileDropdownField(
                                list: value,
                                node: _form.provNode,
                                labelText: textLabelProv,
                                errorText: textErrorEmptyProv,
                                isLoading: value.isEmpty,
                                selectedItem: _form.selectedItemProvField(),
                                onChanged: (item) =>
                                    _form.onChangedProvField(item));
                          }),
                      ValueListenableBuilder<List<CityModel>>(
                          valueListenable: _form.cities,
                          builder: (_, value, __) {
                            return ProfileDropdownField(
                                list: value,
                                node: _form.cityNode,
                                labelText: textLabelCity,
                                errorText: textErrorEmptyCity,
                                isLoading:
                                    value.isEmpty && _form.provId.value != '',
                                selectedItem: _form.selectedItemCityField(),
                                onChanged: (item) =>
                                    _form.onChangedCityField(item));
                          })
                    ])))));
  }
}
