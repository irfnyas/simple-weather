import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_flutter/display/component/exit_dialog.dart';
import 'package:weather_flutter/display/component/profile_field.dart';
import 'package:weather_flutter/domain/controller/form_controller.dart';
import 'package:weather_flutter/domain/model/city_model.dart';
import 'package:weather_flutter/domain/model/province_model.dart';
import 'package:weather_flutter/domain/util/constant.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _form = Get.put(FormController());

    return WillPopScope(
      onWillPop: () {
        if (!_form.isLoggedIn()) {
          Get.dialog(const ExitDialog());
        }
        return Future.value(_form.isLoggedIn());
      },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: _form.isLoggedIn(),
            actions: [
              TextButton(child: const Text(textSave), onPressed: _form.submit),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _form.key,
              child: Column(
                children: [
                  ProfileField(
                      controller: _form.nameController,
                      node: _form.nameNode,
                      label: textLabelName,
                      hint: textHintName),
                  Obx(() => DropdownSearch<ProvinceModel>(
                        mode: Mode.BOTTOM_SHEET,
                        showSearchBox: true,
                        dropdownSearchDecoration: const InputDecoration(
                            labelText: textLabelProv, border: InputBorder.none),
                        focusNode: _form.provNode,
                        enabled: _form.provinces.toList().isNotEmpty,
                        items: _form.provinces.toList(),
                        itemAsString: (item) => item?.name ?? '',
                        onChanged: (item) =>
                            item != null ? _form.setProvince(item) : null,
                        selectedItem: _form.provinces.isNotEmpty
                            ? _form.provinces.firstWhereOrNull(
                                (item) => item.id == _form.provId.value)
                            : null,
                        validator: (ProvinceModel? item) =>
                            item == null ? textErrorEmptyProv : null,
                      )),
                  const SizedBox(height: 16),
                  Obx(() => DropdownSearch<CityModel>(
                        mode: Mode.BOTTOM_SHEET,
                        showSearchBox: true,
                        focusNode: _form.cityNode,
                        dropdownSearchDecoration: const InputDecoration(
                            labelText: textLabelCity, border: InputBorder.none),
                        enabled: _form.cities.toList().isNotEmpty,
                        items: _form.cities.toList(),
                        itemAsString: (item) => item?.name ?? '',
                        onChanged: (item) =>
                            item != null ? _form.setCity(item) : null,
                        selectedItem: _form.cities.isNotEmpty
                            ? _form.cities.firstWhereOrNull(
                                (item) => item.id == _form.cityId.value)
                            : null,
                        validator: (CityModel? item) =>
                            item == null ? textErrorEmptyCity : null,
                      ))
                ],
              ),
            ),
          )),
    );
  }
}
