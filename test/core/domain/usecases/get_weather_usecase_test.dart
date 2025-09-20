import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/errors/failures.dart';
import 'package:flutter_weather_app/core/domain/entities/weather.dart';
import 'package:flutter_weather_app/core/domain/repositories/weather_repository.dart';
import 'package:flutter_weather_app/core/domain/usecases/get_weather_usecase.dart';

import 'get_weather_usecase_test.mocks.dart';

@GenerateMocks([WeatherRepository])
void main() {
  late GetWeatherUseCase useCase;
  late MockWeatherRepository mockRepository;

  setUp(() {
    mockRepository = MockWeatherRepository();
    useCase = GetWeatherUseCase(mockRepository);
  });

  group('call', () {
    const testCityName = 'London';
    const testLang = 'ru';
    final testWeather = Weather(
      cityName: 'London',
      temperature: 20.0,
      description: 'ясно',
      icon: '01d',
      feelsLike: 18.5,
      humidity: 65,
      windSpeed: 3.5,
      dateTime: DateTime(2023, 1, 1, 12, 0),
    );

    test('должен возвращать погоду при успешном запросе', () async {
      // Arrange
      when(mockRepository.getCurrentWeather(testCityName, testLang))
          .thenAnswer((_) async => Right(testWeather));

      // Act
      final result = await useCase(testCityName, testLang);

      // Assert
      expect(result, isA<Right<Failure, Weather>>());
      result.fold(
        (failure) => fail('Не должно быть ошибки'),
        (weather) {
          expect(weather, equals(testWeather));
          expect(weather.cityName, equals('London'));
          expect(weather.temperature, equals(20.0));
        },
      );
      verify(mockRepository.getCurrentWeather(testCityName, testLang));
      verifyNoMoreInteractions(mockRepository);
    });

    test('должен возвращать ValidationFailure при пустом названии города', () async {
      // Act
      final result = await useCase('', testLang);

      // Assert
      expect(result, isA<Left<Failure, Weather>>());
      result.fold(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.toString(), contains('City name cannot be empty'));
        },
        (weather) => fail('Не должно быть погоды'),
      );
      verifyNever(mockRepository.getCurrentWeather(any, any));
    });

    test('должен принимать пустой язык и передавать в репозиторий', () async {
      // Arrange
      when(mockRepository.getCurrentWeather(testCityName, ''))
          .thenAnswer((_) async => Right(testWeather));

      // Act
      final result = await useCase(testCityName, '');

      // Assert
      expect(result, isA<Right<Failure, Weather>>());
      result.fold(
        (failure) => fail('Не должно быть ошибки'),
        (weather) => expect(weather, equals(testWeather)),
      );
      verify(mockRepository.getCurrentWeather(testCityName, ''));
    });

    test('должен принимать валидные названия городов', () async {
      // Arrange
      const validCityName = 'New York';
      when(mockRepository.getCurrentWeather(validCityName, testLang))
          .thenAnswer((_) async => Right(testWeather));

      // Act
      final result = await useCase(validCityName, testLang);

      // Assert
      expect(result, isA<Right<Failure, Weather>>());
      result.fold(
        (failure) => fail('Не должно быть ошибки'),
        (weather) => expect(weather, equals(testWeather)),
      );
      verify(mockRepository.getCurrentWeather(validCityName, testLang));
    });

    test('должен принимать названия городов с пробелами', () async {
      // Arrange
      const cityNameWithSpaces = 'San Francisco';
      when(mockRepository.getCurrentWeather(cityNameWithSpaces, testLang))
          .thenAnswer((_) async => Right(testWeather));

      // Act
      final result = await useCase(cityNameWithSpaces, testLang);

      // Assert
      expect(result, isA<Right<Failure, Weather>>());
      result.fold(
        (failure) => fail('Не должно быть ошибки'),
        (weather) => expect(weather, equals(testWeather)),
      );
      verify(mockRepository.getCurrentWeather(cityNameWithSpaces, testLang));
    });

    test('должен принимать названия городов с кириллицей', () async {
      // Arrange
      const cyrillicCityName = 'Москва';
      when(mockRepository.getCurrentWeather(cyrillicCityName, testLang))
          .thenAnswer((_) async => Right(testWeather));

      // Act
      final result = await useCase(cyrillicCityName, testLang);

      // Assert
      expect(result, isA<Right<Failure, Weather>>());
      result.fold(
        (failure) => fail('Не должно быть ошибки'),
        (weather) => expect(weather, equals(testWeather)),
      );
      verify(mockRepository.getCurrentWeather(cyrillicCityName, testLang));
    });

    test('должен возвращать ошибку репозитория при неудаче', () async {
      // Arrange
      when(mockRepository.getCurrentWeather(testCityName, testLang))
          .thenAnswer((_) async => Left(ServerFailure('Ошибка сервера')));

      // Act
      final result = await useCase(testCityName, testLang);

      // Assert
      expect(result, isA<Left<Failure, Weather>>());
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.toString(), contains('Ошибка сервера'));
        },
        (weather) => fail('Не должно быть погоды'),
      );
      verify(mockRepository.getCurrentWeather(testCityName, testLang));
    });

    test('должен возвращать NetworkFailure при сетевой ошибке', () async {
      // Arrange
      when(mockRepository.getCurrentWeather(testCityName, testLang))
          .thenAnswer((_) async => Left(NetworkFailure('Нет интернета')));

      // Act
      final result = await useCase(testCityName, testLang);

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
  });
}