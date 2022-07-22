import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_weather/data/cache.dart';
import 'package:simple_weather/domain/util/constant.dart';

void main() {
  group('cache test', () {
    test('set string', () async {
      const cacheTestKey = 'cacheTestKey';
      const testValue = 'weather-for-test';
      const expectedValue = 'weather-for-test';

      await cacheWrite(cacheTestKey, testValue);

      expect(await cacheRead(cacheTestKey), expectedValue);
    });

    test('set int', () async {
      const cacheTestKey = 'cacheTestKey';
      const testValue = 23;
      const expectedValue = 23;

      await cacheWrite(cacheTestKey, testValue);

      expect(await cacheRead(cacheTestKey), expectedValue);
    });

    test('set double', () async {
      const cacheTestKey = 'cacheTestKey';
      const testValue = 23.4;
      const expectedValue = 23.4;

      await cacheWrite(cacheTestKey, testValue);

      expect(await cacheRead(cacheTestKey), expectedValue);
    });

    test('set bool', () async {
      const cacheTestKey = 'cacheTestKey';
      const testValue = true;
      const expectedValue = true;

      await cacheWrite(cacheTestKey, testValue);

      expect(await cacheRead(cacheTestKey), expectedValue);
    });

    test('set list', () async {
      const cacheTestKey = 'cacheTestKey';
      const testValue = ['weather', 23, 23.4, true];
      const expectedValue = ['weather', '23', '23.4', 'true'];

      await cacheWrite(cacheTestKey, testValue);

      expect(await cacheRead(cacheTestKey), expectedValue);
    });

    test('remove', () async {
      const cacheTestKey = 'cacheTestKey';
      const testValue = 'weather-for-test';
      const expectedValue = null;

      await cacheWrite(cacheTestKey, testValue);
      await cacheRemove(cacheTestKey);

      expect(await cacheRead(cacheTestKey), expectedValue);
    });

    test('remove', () async {
      const cacheTestKey = 'cacheTestKey';
      const testValue = 'weather-for-test';
      const expectedValue = null;

      const cacheTestKey2 = 'cacheTestKey2';
      const testValue2 = 'weather-for-test';
      const expectedValue2 = null;

      await cacheWrite(cacheTestKey, testValue);
      await cacheWrite(cacheTestKey2, testValue2);
      await cacheClear();

      expect(await cacheRead(cacheTestKey), expectedValue);
      expect(await cacheRead(cacheTestKey2), expectedValue2);
    });

    test('isLoggedIn', () async {
      SharedPreferences.setMockInitialValues({cacheName: 'user'});
      expect(await cacheIsLoggedIn(), true);
    });
  });
}
