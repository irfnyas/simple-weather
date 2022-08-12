import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:simple_weather/domain/util/constant.dart';

class ProfileDropdownField extends StatelessWidget {
  const ProfileDropdownField({
    Key? key,
    required this.list,
    required this.labelText,
    required this.errorText,
    required this.isLoading,
    required this.selectedItem,
    required this.onChanged,
  }) : super(key: key);

  final List list;
  final String labelText;
  final String errorText;
  final bool isLoading;
  final dynamic selectedItem;
  final Function(dynamic) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(children: [
        DropdownSearch<dynamic>(
          enabled: list.isNotEmpty,
          onChanged: onChanged,
          items: list,
          itemAsString: (item) => item?.name ?? '',
          validator: (item) => item == null ? errorText : null,
          selectedItem: selectedItem,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration:
                InputDecoration(labelText: labelText, border: InputBorder.none),
          ),
          popupProps: const PopupProps.modalBottomSheet(
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              maxLines: 1,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: InputDecoration(
                hintText: textSearch,
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
        Visibility(
          visible: isLoading,
          child: const LinearProgressIndicator(minHeight: 2),
        ),
      ]),
    );
  }
}
