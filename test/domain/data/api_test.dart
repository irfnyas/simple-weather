import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_weather/data/api.dart';

void main() {
  group('api test', () {
    test('get provinces', () async {
      const expectedStatusCode = 200;

      final res = await Api.getProvinces();

      expect(res?.statusCode, expectedStatusCode);
    });

    test('get cities', () async {
      const expectedStatusCode = 200;

      final res = await Api.getCities('31');

      expect(res?.statusCode, expectedStatusCode);
    });

    test('get forecast', () async {
      dotenv.testLoad(fileInput: File('.env').readAsStringSync());
      const expectedStatusCode = 200;
      const latTest = '-6.9147444';
      const lngTest = '107.6098111';

      final res = await Api.getForecast(latTest, lngTest);

      expect(res?.statusCode, expectedStatusCode);
    });
  });
}
