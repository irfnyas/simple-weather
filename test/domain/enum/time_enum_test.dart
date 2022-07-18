import 'package:flutter_test/flutter_test.dart';
import 'package:simple_weather/domain/enum/time_enum.dart';
import 'package:simple_weather/domain/util/constant.dart';

void main() {
  group('time enum', () {
    test('get morning greeting', () {
      final testValue = Time.morning.greet;
      const expectedValue = textTimeMorning;
      expect(testValue, expectedValue);
    });

    test('get afternoon greeting', () {
      final testValue = Time.afternoon.greet;
      const expectedValue = textTimeAfternoon;
      expect(testValue, expectedValue);
    });

    test('get evening greeting', () {
      final testValue = Time.evening.greet;
      const expectedValue = textTimeEvening;
      expect(testValue, expectedValue);
    });

    test('get night greeting', () {
      final testValue = Time.night.greet;
      const expectedValue = textTimeNight;
      expect(testValue, expectedValue);
    });
  });
}
