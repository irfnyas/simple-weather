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

      await Cache.write(cacheTestKey, testValue);

      expect(await Cache.read(cacheTestKey), expectedValue);
    });

    test('set int', () async {
      const cacheTestKey = 'cacheTestKey';
      const testValue = 23;
      const expectedValue = 23;

      await Cache.write(cacheTestKey, testValue);

      expect(await Cache.read(cacheTestKey), expectedValue);
    });

    test('set double', () async {
      const cacheTestKey = 'cacheTestKey';
      const testValue = 23.4;
      const expectedValue = 23.4;

      await Cache.write(cacheTestKey, testValue);

      expect(await Cache.read(cacheTestKey), expectedValue);
    });

    test('set bool', () async {
      const cacheTestKey = 'cacheTestKey';
      const testValue = true;
      const expectedValue = true;

      await Cache.write(cacheTestKey, testValue);

      expect(await Cache.read(cacheTestKey), expectedValue);
    });

    test('set list', () async {
      const cacheTestKey = 'cacheTestKey';
      const testValue = ['weather', 23, 23.4, true];
      const expectedValue = ['weather', '23', '23.4', 'true'];

      await Cache.write(cacheTestKey, testValue);

      expect(await Cache.read(cacheTestKey), expectedValue);
    });

    test('remove', () async {
      const cacheTestKey = 'cacheTestKey';
      const testValue = 'weather-for-test';
      const expectedValue = null;

      await Cache.write(cacheTestKey, testValue);
      await Cache.remove(cacheTestKey);

      expect(await Cache.read(cacheTestKey), expectedValue);
    });

    test('remove', () async {
      const cacheTestKey = 'cacheTestKey';
      const testValue = 'weather-for-test';
      const expectedValue = null;

      const cacheTestKey2 = 'cacheTestKey2';
      const testValue2 = 'weather-for-test';
      const expectedValue2 = null;

      await Cache.write(cacheTestKey, testValue);
      await Cache.write(cacheTestKey2, testValue2);
      await Cache.clear();

      expect(await Cache.read(cacheTestKey), expectedValue);
      expect(await Cache.read(cacheTestKey2), expectedValue2);
    });

    test('isLoggedIn', () async {
      SharedPreferences.setMockInitialValues({prefName: 'user'});
      expect(await Cache.isLoggedIn(), true);
    });
  });
}
