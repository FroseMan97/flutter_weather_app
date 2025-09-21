import 'package:flutter_test/flutter_test.dart';
import 'package:weather_data/weather_data.dart';
import 'package:weather_core/weather_core.dart' hide test;

void main() {
  group('CitiesApi', () {
    late CitiesApi citiesApi;
    late DioClient dioClient;

    setUp(() {
      dioClient = DioClient();
      citiesApi = CitiesApi(dioClient);
    });

    test('should be created successfully', () {
      expect(citiesApi, isNotNull);
    });

    test('should have refreshToken method', () {
      expect(() => citiesApi.refreshToken(), returnsNormally);
    });
  });
}
