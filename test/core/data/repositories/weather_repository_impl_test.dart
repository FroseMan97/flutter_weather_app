import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_weather_app/core/errors/exceptions.dart';
import 'package:flutter_weather_app/core/data/datasources/weather_local_datasource.dart';
import 'package:flutter_weather_app/core/data/datasources/weather_remote_datasource.dart';
import 'package:flutter_weather_app/core/data/mappers/weather_mapper.dart';
import 'package:flutter_weather_app/core/data/models/weather_model.dart' as model;
import 'package:flutter_weather_app/core/data/repositories/weather_repository_impl.dart';

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

    test('должен возвращать кешированную погоду когда она есть в кеше', () async {
      // Arrange
      when(mockLocalDataSource.getCachedWeather(testCityName))
          .thenAnswer((_) async => testWeatherModel);
      final testWeather = weatherMapper.toEntity(testWeatherModel);

      // Act
      final result = await repository.getCurrentWeather(testCityName, testLang);

      // Assert
      expect(result.cityName, equals(testWeather.cityName));
      expect(result.temperature, equals(testWeather.temperature));
      expect(result.description, equals(testWeather.description));
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
      final testWeather = weatherMapper.toEntity(testWeatherModel);

      // Act
      final result = await repository.getCurrentWeather(testCityName, testLang);

      // Assert
      expect(result.cityName, equals(testWeather.cityName));
      expect(result.temperature, equals(testWeather.temperature));
      expect(result.description, equals(testWeather.description));
      verify(mockLocalDataSource.getCachedWeather(testCityName));
      verify(mockRemoteDataSource.getCurrentWeather(testCityName, testLang));
      verify(mockLocalDataSource.cacheWeather(testCityName, testWeatherModel));
    });

    test('должен пробрасывать ServerException', () async {
      // Arrange
      when(mockLocalDataSource.getCachedWeather(testCityName))
          .thenAnswer((_) async => null);
      when(mockRemoteDataSource.getCurrentWeather(testCityName, testLang))
          .thenThrow(ServerException('Сервер недоступен'));

      // Act & Assert
      expect(
        () => repository.getCurrentWeather(testCityName, testLang),
        throwsA(isA<ServerException>().having(
          (e) => e.message,
          'message',
          'Сервер недоступен',
        )),
      );
    });


    test('должен пробрасывать NetworkException при пустом кеше', () async {
      // Arrange
      when(mockLocalDataSource.getCachedWeather(testCityName))
          .thenAnswer((_) async => null);
      when(mockRemoteDataSource.getCurrentWeather(testCityName, testLang))
          .thenThrow(NetworkException('Нет интернета'));

      // Act & Assert
      expect(
        () => repository.getCurrentWeather(testCityName, testLang),
        throwsA(isA<NetworkException>().having(
          (e) => e.message,
          'message',
          'Нет интернета',
        )),
      );
    });

    test('должен пробрасывать CacheException', () async {
      // Arrange
      when(mockLocalDataSource.getCachedWeather(testCityName))
          .thenAnswer((_) async => null);
      when(mockRemoteDataSource.getCurrentWeather(testCityName, testLang))
          .thenAnswer((_) async => testWeatherModel);
      when(mockLocalDataSource.cacheWeather(testCityName, testWeatherModel))
          .thenThrow(CacheException('Ошибка кеша'));

      // Act & Assert
      expect(
        () => repository.getCurrentWeather(testCityName, testLang),
        throwsA(isA<CacheException>().having(
          (e) => e.message,
          'message',
          'Ошибка кеша',
        )),
      );
    });

    test('должен пробрасывать неожиданную ошибку', () async {
      // Arrange
      when(mockLocalDataSource.getCachedWeather(testCityName))
          .thenAnswer((_) async => null);
      when(mockRemoteDataSource.getCurrentWeather(testCityName, testLang))
          .thenThrow(Exception('Неожиданная ошибка'));

      // Act & Assert
      expect(
        () => repository.getCurrentWeather(testCityName, testLang),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Неожиданная ошибка'),
        )),
      );
    });
  });
}