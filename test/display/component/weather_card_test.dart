import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_weather/display/component/weather_card.dart';
import 'package:simple_weather/domain/model/weather_model.dart';

void main() {
  setUpAll(() => HttpOverrides.global = null);
  group('weather card test', () {
    testWidgets('has date, degrees, icon and condition', (tester) async {
      final weather = WeatherModel(
          degrees: '23',
          condition: 'Clear sky',
          date: 'TUE 2',
          icon: 'http://openweathermap.org/img/wn/01d.png');
      final degreesText = find.text('${weather.degrees}°');
      final conditionText = find.text(weather.condition);
      final dateText = find.text(weather.date);
      final iconImage = find.byType(Image);

      await tester.pumpWidget(
          MaterialApp(home: Scaffold(body: WeatherCard(weather: weather))));
      await tester.pump();

      expect(degreesText, findsOneWidget);
      expect(conditionText, findsOneWidget);
      expect(dateText, findsOneWidget);
      expect(iconImage, findsOneWidget);
    });
  });
}
