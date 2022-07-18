import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:simple_weather/data/cache.dart';
import 'package:simple_weather/display/component/weather_card.dart';
import 'package:simple_weather/domain/interactor/form_interactor.dart';
import 'package:simple_weather/domain/interactor/weather_interactor.dart';
import 'package:simple_weather/domain/util/constant.dart';
import 'package:simple_weather/domain/util/service_locator.dart';
import 'package:simple_weather/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('first time using app', (tester) async {
      // init main
      await Cache.clear();
      await app.main();

      // init interactor
      final _formInteractor = sl<FormInteractor>();
      final _weatherInteractor = sl<WeatherInteractor>();

      // init finder

      const _nameInput = 'master weather';
      const _provInput = 'jawa barat';
      const _cityInput = 'kota bandung';

      final _nameField = find.byType(TextFormField);
      final _provField = find.byType(DropdownSearch).first;
      final _cityField = find.byType(DropdownSearch).last;
      final _resProvTile = find.text(_provInput.toUpperCase());
      final _resCityTile = find.text(_cityInput.toUpperCase());

      final _errorEmptyProvField = find.text(textErrorEmptyProv);
      final _searchField = find.byType(TextField).last;
      final _listView = find.byType(ListView);
      final _saveBtn = find.text(textSave);

      // click save btn
      await tester.pumpAndSettle();
      await tester.tap(_saveBtn);
      await tester.pumpAndSettle();
      expect(_formInteractor.nameNode.hasFocus, true);
      expect(_errorEmptyProvField, findsOneWidget);

      // set name field and click save btn
      await tester.enterText(_nameField, _nameInput);
      await tester.pumpAndSettle();
      await tester.tap(_saveBtn);
      await tester.pumpAndSettle();
      expect(_formInteractor.nameNode.hasFocus, false);

      // set prov field, search 'JAWA BARAT' and click the result tile
      await tester.tap(_provField);
      await tester.pumpAndSettle();
      await tester.enterText(_searchField, _provInput);
      await tester.pumpAndSettle();
      await tester.tap(_resProvTile);
      await tester.pumpAndSettle();
      expect(find.text(_provInput.toUpperCase()), findsOneWidget);

      // set city field, drag list until 'KOTA BANDUNG' visible and click the tile
      await tester.tap(_cityField);
      await tester.pumpAndSettle();
      await tester.dragUntilVisible(
          _resCityTile, _listView, const Offset(0, -50));
      await tester.pumpAndSettle();
      await tester.tap(_resCityTile);
      await tester.pumpAndSettle();
      expect(find.text(_cityInput.toUpperCase()), findsOneWidget);

      // click save and go to today screen
      await tester.tap(_saveBtn);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byIcon(Icons.settings_outlined), findsOneWidget);

      // ensure loading is finished
      while (_weatherInteractor.weathers.value.isEmpty) {
        await tester.pumpAndSettle(const Duration(seconds: 1));
      }

      // today screen has greeting, city text, name text and 5 forecast weather cards
      expect(find.text(_weatherInteractor.greeting.value), findsOneWidget);
      expect(find.text(_cityInput.toUpperCase()), findsOneWidget);
      expect(find.text(_nameInput.toUpperCase()), findsOneWidget);
      expect(find.byType(WeatherCard, skipOffstage: false), findsNWidgets(5));
    });
  });
}
