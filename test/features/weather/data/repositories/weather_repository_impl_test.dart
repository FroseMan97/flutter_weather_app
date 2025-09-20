import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_weather_app/core/errors/exceptions.dart';
import 'package:flutter_weather_app/core/errors/failures.dart';
import 'package:flutter_weather_app/shared/components/weather/data/datasources/weather_remote_datasource.dart';
import 'package:flutter_weather_app/shared/components/weather/data/mappers/weather_mapper.dart';
import 'package:flutter_weather_app/shared/components/weather/data/models/weather_model.dart';
import 'package:flutter_weather_app/shared/components/weather/data/repositories/weather_repository_impl.dart';
import 'package:flutter_weather_app/shared/components/weather/domain/entities/weather.dart' as domain;

import 'weather_repository_impl_test.mocks.dart';

@GenerateMocks([WeatherRemoteDataSource])
void main() {
  late WeatherRepositoryImpl repository;
  late MockWeatherRemoteDataSource mockRemoteDataSource;
  late WeatherMapper weatherMapper;

  setUp(() {
    mockRemoteDataSource = MockWeatherRemoteDataSource();
    weatherMapper = WeatherMapper();
    repository = WeatherRepositoryImpl(mockRemoteDataSource, weatherMapper);
  });

  group('getCurrentWeather', () {
    const testCityName = 'London';
    final testWeatherModel = WeatherModel(
      coord: Coord(lon: 0.0, lat: 0.0),
      weather: [
        Weather(
          id: 0,
          main: 'Clear',
          description: 'clear sky',
          icon: '01d',
        )
      ],
      base: 'stations',
      main: Main(
        temp: 20.0,
        feelsLike: 22.0,
        tempMin: 18.0,
        tempMax: 22.0,
        pressure: 1013,
        humidity: 65,
      ),
      visibility: 10000,
      wind: Wind(
        speed: 3.5,
        deg: 0,
      ),
      clouds: Clouds(all: 0),
      dt: 1672574400, // 2023-01-01 12:00:00 UTC
      sys: Sys(
        type: 1,
        id: 0,
        country: 'GB',
        sunrise: 1672531200,
        sunset: 1672567200,
      ),
      timezone: 0,
      id: 0,
      name: 'London',
      cod: 200,
    );

    test('should return Weather entity when remote data source is successful', () async {
      // Arrange
      when(mockRemoteDataSource.getCurrentWeather(testCityName, 'en'))
          .thenAnswer((_) async => testWeatherModel);

      // Act
      final result = await repository.getCurrentWeather(testCityName, 'en');

      // Assert
      expect(result, isA<domain.Weather>());
      expect(result.cityName, equals('London'));
      expect(result.temperature, equals(20.0));
      expect(result.description, equals('clear sky'));
      expect(result.icon, equals('01d'));
      expect(result.feelsLike, equals(22.0));
      expect(result.humidity, equals(65));
      expect(result.windSpeed, equals(3.5));

      verify(mockRemoteDataSource.getCurrentWeather(testCityName, 'en')).called(1);
    });

    test('should throw ServerFailure when remote data source throws ServerException', () async {
      // Arrange
      when(mockRemoteDataSource.getCurrentWeather(testCityName, 'en'))
          .thenThrow(const ServerException('Server error'));

      // Act & Assert
      expect(
        () => repository.getCurrentWeather(testCityName, 'en'),
        throwsA(isA<ServerFailure>()),
      );
    });

    test('should throw NetworkFailure when remote data source throws NetworkException', () async {
      // Arrange
      when(mockRemoteDataSource.getCurrentWeather(testCityName, 'en'))
          .thenThrow(const NetworkException('Network error'));

      // Act & Assert
      expect(
        () => repository.getCurrentWeather(testCityName, 'en'),
        throwsA(isA<NetworkFailure>()),
      );
    });

    test('should throw ServerFailure when remote data source throws CacheException', () async {
      // Arrange
      when(mockRemoteDataSource.getCurrentWeather(testCityName, 'en'))
          .thenThrow(const CacheException('Cache error'));

      // Act & Assert
      expect(
        () => repository.getCurrentWeather(testCityName, 'en'),
        throwsA(isA<ServerFailure>()),
      );
    });
  });
}
