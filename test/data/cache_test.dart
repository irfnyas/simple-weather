import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_weather/data/cache.dart' as cache;
import 'package:simple_weather/domain/util/constant.dart';

void main() {
  group('cache test', () {
    test('set string', () async {
      const cacheTestKey = 'cacheTestKey';
      const testValue = 'weather-for-test';
      const expectedValue = 'weather-for-test';

      await cache.write(cacheTestKey, testValue);

      expect(await cache.read(cacheTestKey), expectedValue);
    });

    test('set int', () async {
      const cacheTestKey = 'cacheTestKey';
      const testValue = 23;
      const expectedValue = 23;

      await cache.write(cacheTestKey, testValue);

      expect(await cache.read(cacheTestKey), expectedValue);
    });

    test('set double', () async {
      const cacheTestKey = 'cacheTestKey';
      const testValue = 23.4;
      const expectedValue = 23.4;

      await cache.write(cacheTestKey, testValue);

      expect(await cache.read(cacheTestKey), expectedValue);
    });

    test('set bool', () async {
      const cacheTestKey = 'cacheTestKey';
      const testValue = true;
      const expectedValue = true;

      await cache.write(cacheTestKey, testValue);

      expect(await cache.read(cacheTestKey), expectedValue);
    });

    test('set list', () async {
      const cacheTestKey = 'cacheTestKey';
      const testValue = ['weather', 23, 23.4, true];
      const expectedValue = ['weather', '23', '23.4', 'true'];

      await cache.write(cacheTestKey, testValue);

      expect(await cache.read(cacheTestKey), expectedValue);
    });

    test('remove', () async {
      const cacheTestKey = 'cacheTestKey';
      const testValue = 'weather-for-test';
      const expectedValue = null;

      await cache.write(cacheTestKey, testValue);
      await cache.remove(cacheTestKey);

      expect(await cache.read(cacheTestKey), expectedValue);
    });

    test('remove', () async {
      const cacheTestKey = 'cacheTestKey';
      const testValue = 'weather-for-test';
      const expectedValue = null;

      const cacheTestKey2 = 'cacheTestKey2';
      const testValue2 = 'weather-for-test';
      const expectedValue2 = null;

      await cache.write(cacheTestKey, testValue);
      await cache.write(cacheTestKey2, testValue2);
      await cache.clear();

      expect(await cache.read(cacheTestKey), expectedValue);
      expect(await cache.read(cacheTestKey2), expectedValue2);
    });

    test('isLoggedIn', () async {
      SharedPreferences.setMockInitialValues({prefName: 'user'});
      expect(await cache.isLoggedIn(), true);
    });
  });
}
