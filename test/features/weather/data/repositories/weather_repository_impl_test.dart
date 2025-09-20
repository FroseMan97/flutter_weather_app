import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/errors/exceptions.dart';
import 'package:flutter_weather_app/core/errors/failures.dart';
import 'package:flutter_weather_app/shared/components/weather/data/datasources/weather_local_datasource.dart';
import 'package:flutter_weather_app/shared/components/weather/data/datasources/weather_remote_datasource.dart';
import 'package:flutter_weather_app/shared/components/weather/data/mappers/weather_mapper.dart';
import 'package:flutter_weather_app/shared/components/weather/data/models/weather_model.dart';
import 'package:flutter_weather_app/shared/components/weather/data/repositories/weather_repository_impl.dart';
import 'package:flutter_weather_app/shared/components/weather/domain/entities/weather.dart' as domain;

import 'weather_repository_impl_test.mocks.dart';

@GenerateMocks([WeatherRemoteDataSource, WeatherLocalDataSource])
void main() {
  late WeatherRepositoryImpl repository;
  late MockWeatherRemoteDataSource mockRemoteDataSource;
  late MockWeatherLocalDataSource mockLocalDataSource;
  late WeatherMapper weatherMapper;

  setUp(() {
    mockRemoteDataSource = MockWeatherRemoteDataSource();
    mockLocalDataSource = MockWeatherLocalDataSource();
    weatherMapper = WeatherMapper();
    repository = WeatherRepositoryImpl(mockRemoteDataSource, mockLocalDataSource, weatherMapper);
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

    test('должен возвращать кешированную погоду при наличии', () async {
      // Подготовка
      when(mockLocalDataSource.getCachedWeather(testCityName))
          .thenAnswer((_) async => testWeatherModel);

      // Действие
      final result = await repository.getCurrentWeather(testCityName, 'en');

      // Проверка
      expect(result, isA<Right<Failure, domain.Weather>>());
      result.fold(
        (failure) => fail('Не должен возвращать ошибку'),
        (weather) {
          expect(weather.cityName, equals('London'));
          expect(weather.temperature, equals(20.0));
          expect(weather.description, equals('clear sky'));
        },
      );
      verify(mockLocalDataSource.getCachedWeather(testCityName)).called(1);
      verifyNever(mockRemoteDataSource.getCurrentWeather(any, any));
    });

    test('должен возвращать сущность Weather при успешном вызове удаленного источника данных', () async {
      // Подготовка
      when(mockLocalDataSource.getCachedWeather(testCityName))
          .thenAnswer((_) async => null);
      when(mockRemoteDataSource.getCurrentWeather(testCityName, 'en'))
          .thenAnswer((_) async => testWeatherModel);
      when(mockLocalDataSource.cacheWeather(testCityName, testWeatherModel))
          .thenAnswer((_) async {});

      // Действие
      final result = await repository.getCurrentWeather(testCityName, 'en');

      // Проверка
      expect(result, isA<Right<Failure, domain.Weather>>());
      result.fold(
        (failure) => fail('Не должен возвращать ошибку'),
        (weather) {
          expect(weather.cityName, equals('London'));
          expect(weather.temperature, equals(20.0));
          expect(weather.description, equals('clear sky'));
          expect(weather.icon, equals('01d'));
          expect(weather.feelsLike, equals(22.0));
          expect(weather.humidity, equals(65));
          expect(weather.windSpeed, equals(3.5));
        },
      );

      verify(mockRemoteDataSource.getCurrentWeather(testCityName, 'en')).called(1);
    });

    test('должен возвращать ServerFailure при ServerException от удаленного источника данных', () async {
      // Подготовка
      when(mockLocalDataSource.getCachedWeather(testCityName))
          .thenAnswer((_) async => null);
      when(mockRemoteDataSource.getCurrentWeather(testCityName, 'en'))
          .thenThrow(const ServerException('Server error'));

      // Действие
      final result = await repository.getCurrentWeather(testCityName, 'en');

      // Проверка
      expect(result, isA<Left<Failure, domain.Weather>>());
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (weather) => fail('Не должен возвращать погоду'),
      );
    });

    test('должен возвращать кешированную погоду при NetworkException', () async {
      // Подготовка
      when(mockLocalDataSource.getCachedWeather(testCityName))
          .thenAnswer((_) async => testWeatherModel);
      when(mockRemoteDataSource.getCurrentWeather(testCityName, 'en'))
          .thenThrow(const NetworkException('Network error'));

      // Действие
      final result = await repository.getCurrentWeather(testCityName, 'en');

      // Проверка
      expect(result, isA<Right<Failure, domain.Weather>>());
      result.fold(
        (failure) => fail('Должен возвращать кешированную погоду'),
        (weather) {
          expect(weather.cityName, equals('London'));
          expect(weather.temperature, equals(20.0));
        },
      );
    });

    test('должен возвращать ServerFailure при CacheException от удаленного источника данных', () async {
      // Подготовка
      when(mockLocalDataSource.getCachedWeather(testCityName))
          .thenAnswer((_) async => null);
      when(mockRemoteDataSource.getCurrentWeather(testCityName, 'en'))
          .thenThrow(const CacheException('Cache error'));

      // Действие
      final result = await repository.getCurrentWeather(testCityName, 'en');

      // Проверка
      expect(result, isA<Left<Failure, domain.Weather>>());
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (weather) => fail('Не должен возвращать погоду'),
      );
    });
  });
}
