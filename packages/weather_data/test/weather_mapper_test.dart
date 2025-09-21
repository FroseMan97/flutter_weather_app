import 'package:flutter_test/flutter_test.dart';
import 'package:weather_data/weather_data.dart';

void main() {
  group('WeatherMapper', () {
    late WeatherMapper mapper;

    setUp(() {
      mapper = WeatherMapper();
    });

    test('should map WeatherModel to Weather correctly', () {
      final weatherModel = WeatherModel(
        name: 'London',
        main: Main(
          temp: 25.0,
          feelsLike: 24.0,
          humidity: 70,
        ),
        wind: Wind(speed: 10.0),
        weather: [
          Weather(
            main: 'Clouds',
            description: 'scattered clouds',
            icon: '03d',
          ),
        ],
        dt: 1640995200,
      );

      final weather = mapper.toEntity(weatherModel);

      expect(weather.cityName, 'London');
      expect(weather.temperature, 25.0);
      expect(weather.feelsLike, 24.0);
      expect(weather.humidity, 70);
      expect(weather.windSpeed, 10.0);
      expect(weather.description, 'scattered clouds');
      expect(weather.icon, '03d');
      expect(weather.dateTime, isA<DateTime>());
    });

    test('should handle null fields gracefully', () {
      final weatherModel = WeatherModel(
        name: null,
        main: null,
        wind: null,
        weather: null,
        dt: null,
      );

      final weather = mapper.toEntity(weatherModel);

      expect(weather.cityName, '');
      expect(weather.temperature, 0.0);
      expect(weather.feelsLike, 0.0);
      expect(weather.humidity, 0);
      expect(weather.windSpeed, 0.0);
      expect(weather.description, '');
      expect(weather.icon, '');
      expect(weather.dateTime, isA<DateTime>());
    });
  });
}
