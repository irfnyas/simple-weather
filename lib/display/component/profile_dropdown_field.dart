import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class ProfileDropdownField extends StatelessWidget {
  const ProfileDropdownField(
      {Key? key,
      required this.node,
      required this.list,
      required this.labelText,
      required this.errorText,
      required this.isLoading,
      required this.selectedItem,
      required this.onChanged})
      : super(key: key);

  final FocusNode node;
  final List list;
  final String labelText;
  final String errorText;
  final bool isLoading;
  final dynamic selectedItem;
  final Function(dynamic) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(children: [
          DropdownSearch<dynamic>(
              showSearchBox: true,
              mode: Mode.BOTTOM_SHEET,
              enabled: list.isNotEmpty,
              focusNode: node,
              onChanged: onChanged,
              items: list,
              itemAsString: (item) => item?.name ?? '',
              validator: (item) => item == null ? errorText : null,
              selectedItem: selectedItem,
              dropdownSearchDecoration: InputDecoration(
                  labelText: labelText, border: InputBorder.none)),
          Visibility(
              visible: isLoading,
              child: const LinearProgressIndicator(minHeight: 2))
        ]));
  }
}
