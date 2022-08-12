import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:simple_weather/data/cache.dart';
import 'package:simple_weather/display/component/weather_card.dart';
import 'package:simple_weather/domain/util/constant.dart';
import 'package:simple_weather/domain/util/service_locator.dart';
import 'package:simple_weather/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test android', () {
    testWidgets('first time using app', (tester) async {
      // arrange init main
      await cacheClear();
      await app.main();

      // arrange var
      const nameInput = 'master weather';
      const provInput = 'jawa barat';
      const cityInput = 'kota bandung';

      final nameField = find.byType(TextFormField);
      final provField = find.byType(DropdownSearch).first;
      final cityField = find.byType(DropdownSearch).last;
      final resProvTile = find.text(provInput.toUpperCase());
      final resCityTile = find.text(cityInput.toUpperCase());

      final errorEmptyProvField = find.text(textErrorEmptyProv);
      final searchField = find.byType(TextField).last;
      final listView = find.byType(ListView);
      final saveBtn = find.text(textSave);

      // act click save btn then show error empty message
      await tester.pumpAndSettle();
      await tester.tap(saveBtn);
      await tester.pumpAndSettle();
      expect(form.nameNode.hasFocus, true);
      expect(errorEmptyProvField, findsOneWidget);

      // act set name field then click save btn
      await tester.enterText(nameField, nameInput);
      await tester.pumpAndSettle();
      await tester.tap(saveBtn);
      await tester.pumpAndSettle();
      expect(form.nameNode.hasFocus, false);

      // act set prov field, search 'JAWA BARAT' then click the result tile
      await tester.tap(provField);
      await tester.pumpAndSettle();
      await tester.enterText(searchField, provInput);
      await tester.pumpAndSettle();
      await tester.tap(resProvTile);
      await tester.pumpAndSettle();
      expect(find.text(provInput.toUpperCase()), findsOneWidget);

      // act set city field, drag list until 'KOTA BANDUNG' visible then click the tile
      await tester.tap(cityField);
      await tester.pumpAndSettle();
      await tester.dragUntilVisible(
        resCityTile,
        listView,
        const Offset(0, -50),
      );
      await tester.pumpAndSettle();
      await tester.tap(resCityTile);
      await tester.pumpAndSettle();
      expect(find.text(cityInput.toUpperCase()), findsOneWidget);

      // act click save then go to today screen
      await tester.tap(saveBtn);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byIcon(Icons.settings_outlined), findsOneWidget);

      // assert loading is finished
      while (weather.weathers.value.isEmpty) {
        await tester.pumpAndSettle(const Duration(seconds: 1));
      }

      // assert today screen has greeting, city text, name text and 5 forecast weather cards
      expect(find.text(weather.greeting.value), findsOneWidget);
      expect(find.text(cityInput.toUpperCase()), findsOneWidget);
      expect(find.text(nameInput.toUpperCase()), findsOneWidget);
      expect(find.byType(WeatherCard, skipOffstage: false), findsNWidgets(5));

      // assert default degrees is celcius
      expect(find.text(textCelcius), findsOneWidget);

      // act click degrees button
      await tester.tap(find.text(textCelcius));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // assert degrees changed to Fahrenheit
      expect(find.text(textFahrenheit), findsOneWidget);
    });
  });
}
