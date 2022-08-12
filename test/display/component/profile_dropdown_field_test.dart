import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_weather/display/component/profile_dropdown_field.dart';
import 'package:simple_weather/domain/model/province_model.dart';

void main() {
  group('profile dropdown field test', () {
    testWidgets('clicked dropdown item change the value', (tester) async {
      final list =
          List.generate(50, ((i) => ProvinceModel(id: '$i', name: 'Item $i')));
      final dropdownField = find.byType(DropdownSearch);
      final itemToSelect = find.text('Item 1');

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ProfileDropdownField(
            list: list,
            labelText: '',
            errorText: '',
            isLoading: false,
            selectedItem: list[0],
            onChanged: (item) => {},
          ),
        ),
      ));

      await tester.tap(dropdownField);
      await tester.pumpAndSettle();
      await tester.tap(itemToSelect);
      await tester.pumpAndSettle();

      expect(itemToSelect, findsOneWidget);
    });

    testWidgets('search value filtered the list', (tester) async {
      final list =
          List.generate(50, ((i) => ProvinceModel(id: '$i', name: 'Item $i')));
      final dropdownField = find.byType(DropdownSearch);
      final itemToSelect = find.text('Item 23').last;
      final searchField = find.byType(TextField);

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ProfileDropdownField(
            list: list,
            labelText: '',
            errorText: '',
            isLoading: false,
            selectedItem: list[0],
            onChanged: (item) => {},
          ),
        ),
      ));

      await tester.tap(dropdownField);
      await tester.pumpAndSettle();
      await tester.enterText(searchField, 'Item 23');
      await tester.pumpAndSettle();
      await tester.tap(itemToSelect);
      await tester.pumpAndSettle();

      expect(itemToSelect, findsOneWidget);
    });

    testWidgets('list draggable', (tester) async {
      final list =
          List.generate(50, ((i) => ProvinceModel(id: '$i', name: 'Item $i')));
      final dropdownField = find.byType(DropdownSearch);
      final itemToSelect = find.text('Item 23');
      final listView = find.byType(ListView);

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ProfileDropdownField(
            list: list,
            labelText: '',
            errorText: '',
            isLoading: false,
            selectedItem: list[0],
            onChanged: (item) => {},
          ),
        ),
      ));

      await tester.tap(dropdownField);
      await tester.pumpAndSettle();
      await tester.dragUntilVisible(
        itemToSelect,
        listView,
        const Offset(0, -50),
      );
      await tester.pumpAndSettle();
      await tester.tap(itemToSelect);
      await tester.pumpAndSettle();

      expect(itemToSelect, findsOneWidget);
    });
  });
}
