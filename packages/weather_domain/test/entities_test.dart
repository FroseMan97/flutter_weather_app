import 'package:flutter_test/flutter_test.dart';
import 'package:weather_domain/weather_domain.dart';

void main() {
  group('City Entity', () {
    test('should be created successfully', () {
      const city = City(
        name: 'Test City',
        countryCode: 'TC',
        iataCode: 'TST',
        stateCode: 'TS',
        latitude: 1.0,
        longitude: 2.0,
      );

      expect(city, isA<City>());
      expect(city.name, 'Test City');
      expect(city.countryCode, 'TC');
      expect(city.iataCode, 'TST');
      expect(city.stateCode, 'TS');
      expect(city.latitude, 1.0);
      expect(city.longitude, 2.0);
    });
  });

  group('Weather Entity', () {
    test('should be created successfully', () {
      final weather = Weather(
        cityName: 'Test City',
        temperature: 25.0,
        description: 'scattered clouds',
        icon: '03d',
        feelsLike: 24.0,
        humidity: 70,
        windSpeed: 10.0,
        dateTime: DateTime.now(),
      );

      expect(weather, isA<Weather>());
      expect(weather.cityName, 'Test City');
      expect(weather.temperature, 25.0);
      expect(weather.feelsLike, 24.0);
      expect(weather.humidity, 70);
      expect(weather.windSpeed, 10.0);
      expect(weather.description, 'scattered clouds');
      expect(weather.icon, '03d');
      expect(weather.dateTime, isA<DateTime>());
    });
  });
}
