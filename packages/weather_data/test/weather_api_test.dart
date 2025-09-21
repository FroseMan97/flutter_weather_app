import 'package:flutter_test/flutter_test.dart';
import 'package:weather_data/weather_data.dart';
import 'package:weather_core/weather_core.dart' hide test;

void main() {
  group('WeatherApi', () {
    late WeatherApi weatherApi;
    late DioClient dioClient;

    setUp(() {
      dioClient = DioClient();
      weatherApi = WeatherApi(dioClient);
    });

    test('should be created successfully', () {
      expect(weatherApi, isNotNull);
    });
  });
}
