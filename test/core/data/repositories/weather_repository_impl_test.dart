import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/errors/exceptions.dart';
import 'package:flutter_weather_app/core/errors/failures.dart';
import 'package:flutter_weather_app/core/data/datasources/weather_local_datasource.dart';
import 'package:flutter_weather_app/core/data/datasources/weather_remote_datasource.dart';
import 'package:flutter_weather_app/core/data/mappers/weather_mapper.dart';
import 'package:flutter_weather_app/core/data/models/weather_model.dart' as model;
import 'package:flutter_weather_app/core/data/repositories/weather_repository_impl.dart';
import 'package:flutter_weather_app/core/domain/entities/weather.dart';

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
    const testLang = 'ru';
    final testWeatherModel = model.WeatherModel(
      coord: model.Coord(lon: -0.1278, lat: 51.5074),
      weather: [
        model.Weather(
          id: 800,
          main: 'Clear',
          description: 'ясно',
          icon: '01d',
        ),
      ],
      base: 'stations',
      main: model.Main(
        temp: 20.0,
        feelsLike: 18.5,
        tempMin: 15.0,
        tempMax: 25.0,
        pressure: 1013,
        humidity: 65,
      ),
      visibility: 10000,
      wind: model.Wind(speed: 3.5, deg: 180),
      clouds: model.Clouds(all: 0),
      dt: 1640995200,
      sys: model.Sys(
        type: 1,
        id: 1414,
        country: 'GB',
        sunrise: 1640952000,
        sunset: 1640988000,
      ),
      timezone: 0,
      id: 2643743,
      name: 'London',
      cod: 200,
    );

    final testWeather = weatherMapper.toEntity(testWeatherModel);

    test('должен возвращать кешированную погоду когда она есть в кеше', () async {
      // Arrange
      when(mockLocalDataSource.getCachedWeather(testCityName))
          .thenAnswer((_) async => testWeatherModel);

      // Act
      final result = await repository.getCurrentWeather(testCityName, testLang);

      // Assert
      expect(result, isA<Right<Failure, Weather>>());
      result.fold(
        (failure) => fail('Не должно быть ошибки'),
        (weather) {
          expect(weather.cityName, equals(testWeather.cityName));
          expect(weather.temperature, equals(testWeather.temperature));
          expect(weather.description, equals(testWeather.description));
        },
      );
      verify(mockLocalDataSource.getCachedWeather(testCityName));
      verifyNever(mockRemoteDataSource.getCurrentWeather(any, any));
    });

    test('должен получать погоду из API и кешировать её когда кеш пуст', () async {
      // Arrange
      when(mockLocalDataSource.getCachedWeather(testCityName))
          .thenAnswer((_) async => null);
      when(mockRemoteDataSource.getCurrentWeather(testCityName, testLang))
          .thenAnswer((_) async => testWeatherModel);
      when(mockLocalDataSource.cacheWeather(testCityName, testWeatherModel))
          .thenAnswer((_) async {});

      // Act
      final result = await repository.getCurrentWeather(testCityName, testLang);

      // Assert
      expect(result, isA<Right<Failure, Weather>>());
      result.fold(
        (failure) => fail('Не должно быть ошибки'),
        (weather) {
          expect(weather.cityName, equals(testWeather.cityName));
          expect(weather.temperature, equals(testWeather.temperature));
          expect(weather.description, equals(testWeather.description));
        },
      );
      verify(mockLocalDataSource.getCachedWeather(testCityName));
      verify(mockRemoteDataSource.getCurrentWeather(testCityName, testLang));
      verify(mockLocalDataSource.cacheWeather(testCityName, testWeatherModel));
    });

    test('должен возвращать ServerFailure при ServerException', () async {
      // Arrange
      when(mockLocalDataSource.getCachedWeather(testCityName))
          .thenAnswer((_) async => null);
      when(mockRemoteDataSource.getCurrentWeather(testCityName, testLang))
          .thenThrow(ServerException('Сервер недоступен'));

      // Act
      final result = await repository.getCurrentWeather(testCityName, testLang);

      // Assert
      expect(result, isA<Left<Failure, Weather>>());
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.toString(), contains('Сервер недоступен'));
        },
        (weather) => fail('Не должно быть погоды'),
      );
    });

    test('должен возвращать кешированную погоду при NetworkException', () async {
      // Arrange
      when(mockLocalDataSource.getCachedWeather(testCityName))
          .thenAnswer((_) async => testWeatherModel);
      when(mockRemoteDataSource.getCurrentWeather(testCityName, testLang))
          .thenThrow(NetworkException('Нет интернета'));

      // Act
      final result = await repository.getCurrentWeather(testCityName, testLang);

      // Assert
      expect(result, isA<Right<Failure, Weather>>());
      result.fold(
        (failure) => fail('Не должно быть ошибки'),
        (weather) {
          expect(weather.cityName, equals(testWeather.cityName));
          expect(weather.temperature, equals(testWeather.temperature));
        },
      );
      verify(mockLocalDataSource.getCachedWeather(testCityName));
      verify(mockRemoteDataSource.getCurrentWeather(testCityName, testLang));
    });

    test('должен возвращать NetworkFailure при NetworkException и пустом кеше', () async {
      // Arrange
      when(mockLocalDataSource.getCachedWeather(testCityName))
          .thenAnswer((_) async => null);
      when(mockRemoteDataSource.getCurrentWeather(testCityName, testLang))
          .thenThrow(NetworkException('Нет интернета'));

      // Act
      final result = await repository.getCurrentWeather(testCityName, testLang);

      // Assert
      expect(result, isA<Left<Failure, Weather>>());
      result.fold(
        (failure) {
          expect(failure, isA<NetworkFailure>());
          expect(failure.toString(), contains('Нет интернета'));
        },
        (weather) => fail('Не должно быть погоды'),
      );
    });

    test('должен возвращать CacheFailure при CacheException', () async {
      // Arrange
      when(mockLocalDataSource.getCachedWeather(testCityName))
          .thenAnswer((_) async => null);
      when(mockRemoteDataSource.getCurrentWeather(testCityName, testLang))
          .thenAnswer((_) async => testWeatherModel);
      when(mockLocalDataSource.cacheWeather(testCityName, testWeatherModel))
          .thenThrow(CacheException('Ошибка кеша'));

      // Act
      final result = await repository.getCurrentWeather(testCityName, testLang);

      // Assert
      expect(result, isA<Left<Failure, Weather>>());
      result.fold(
        (failure) {
          expect(failure, isA<CacheFailure>());
          expect(failure.toString(), contains('Ошибка кеша'));
        },
        (weather) => fail('Не должно быть погоды'),
      );
    });

    test('должен возвращать ServerFailure при неожиданной ошибке', () async {
      // Arrange
      when(mockLocalDataSource.getCachedWeather(testCityName))
          .thenAnswer((_) async => null);
      when(mockRemoteDataSource.getCurrentWeather(testCityName, testLang))
          .thenThrow(Exception('Неожиданная ошибка'));

      // Act
      final result = await repository.getCurrentWeather(testCityName, testLang);

      // Assert
      expect(result, isA<Left<Failure, Weather>>());
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.toString(), contains('Неожиданная ошибка'));
        },
        (weather) => fail('Не должно быть погоды'),
      );
    });
  });
}