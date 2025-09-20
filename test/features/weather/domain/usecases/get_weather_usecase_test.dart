import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/errors/failures.dart';
import 'package:flutter_weather_app/shared/components/weather_widget/domain/entities/weather.dart';
import 'package:flutter_weather_app/shared/components/weather_widget/domain/repositories/weather_repository.dart';
import 'package:flutter_weather_app/shared/components/weather_widget/domain/usecases/get_weather_usecase.dart';

import 'get_weather_usecase_test.mocks.dart';

@GenerateMocks([WeatherRepository])
void main() {
  late GetWeatherUseCase useCase;
  late MockWeatherRepository mockRepository;

  setUp(() {
    mockRepository = MockWeatherRepository();
    useCase = GetWeatherUseCase(mockRepository);
  });

  group('GetWeatherUseCase', () {
    const testCityName = 'London';
    const testLanguageCode = 'en';
    final testWeather = Weather(
      cityName: 'London',
      temperature: 20.0,
      description: 'clear sky',
      icon: '01d',
      feelsLike: 22.0,
      humidity: 65,
      windSpeed: 3.5,
      dateTime: DateTime(2023, 1, 1, 12, 0),
    );

    test('должен возвращать погоду при успешном вызове репозитория', () async {
      // Подготовка
      when(mockRepository.getCurrentWeather(testCityName, testLanguageCode))
          .thenAnswer((_) async => Right(testWeather));

      // Действие
      final result = await useCase(testCityName, testLanguageCode);

      // Проверка
      expect(result, isA<Right<Failure, Weather>>());
      result.fold(
        (failure) => fail('Не должен возвращать ошибку'),
        (weather) {
          expect(weather, equals(testWeather));
          expect(weather.cityName, equals('London'));
          expect(weather.temperature, equals(20.0));
          expect(weather.description, equals('clear sky'));
        },
      );
      verify(mockRepository.getCurrentWeather(testCityName, testLanguageCode)).called(1);
    });

    test('должен возвращать ValidationFailure при пустом названии города', () async {
      // Действие
      final result = await useCase('', testLanguageCode);

      // Проверка
      expect(result, isA<Left<Failure, Weather>>());
      result.fold(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.toString(), contains('City name cannot be empty'));
        },
        (weather) => fail('Не должен возвращать погоду'),
      );
      verifyNever(mockRepository.getCurrentWeather(any, any));
    });

    test('должен возвращать ValidationFailure при слишком коротком названии города', () async {
      // Действие
      final result = await useCase('L', testLanguageCode);

      // Проверка
      expect(result, isA<Left<Failure, Weather>>());
      result.fold(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.toString(), contains('City name must be at least 2 characters'));
        },
        (weather) => fail('Не должен возвращать погоду'),
      );
      verifyNever(mockRepository.getCurrentWeather(any, any));
    });

    test('должен возвращать ValidationFailure при недопустимых символах в названии города', () async {
      // Действие
      final result = await useCase('London123', testLanguageCode);

      // Проверка
      expect(result, isA<Left<Failure, Weather>>());
      result.fold(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.toString(), contains('City name can only contain letters and spaces'));
        },
        (weather) => fail('Не должен возвращать погоду'),
      );
      verifyNever(mockRepository.getCurrentWeather(any, any));
    });

    test('должен возвращать ValidationFailure при пустом коде языка', () async {
      // Действие
      final result = await useCase(testCityName, '');

      // Проверка
      expect(result, isA<Left<Failure, Weather>>());
      result.fold(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.toString(), contains('Language code cannot be empty'));
        },
        (weather) => fail('Не должен возвращать погоду'),
      );
      verifyNever(mockRepository.getCurrentWeather(any, any));
    });

    test('должен возвращать ValidationFailure при неверном коде языка', () async {
      // Действие
      final result = await useCase(testCityName, 'english');

      // Проверка
      expect(result, isA<Left<Failure, Weather>>());
      result.fold(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.toString(), contains('Language code must be 2 lowercase letters'));
        },
        (weather) => fail('Не должен возвращать погоду'),
      );
      verifyNever(mockRepository.getCurrentWeather(any, any));
    });

    test('должен возвращать ValidationFailure при заглавных буквах в коде языка', () async {
      // Действие
      final result = await useCase(testCityName, 'EN');

      // Проверка
      expect(result, isA<Left<Failure, Weather>>());
      result.fold(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.toString(), contains('Language code must be 2 lowercase letters'));
        },
        (weather) => fail('Не должен возвращать погоду'),
      );
      verifyNever(mockRepository.getCurrentWeather(any, any));
    });

    test('должен разрешать пробелы в названии города', () async {
      // Подготовка
      when(mockRepository.getCurrentWeather('New York', testLanguageCode))
          .thenAnswer((_) async => Right(testWeather));

      // Действие
      final result = await useCase('New York', testLanguageCode);

      // Проверка
      expect(result, isA<Right<Failure, Weather>>());
      result.fold(
        (failure) => fail('Не должен возвращать ошибку'),
        (weather) => expect(weather, equals(testWeather)),
      );
      verify(mockRepository.getCurrentWeather('New York', testLanguageCode)).called(1);
    });

    test('должен возвращать ошибку при неудачном вызове репозитория', () async {
      // Подготовка
      when(mockRepository.getCurrentWeather(testCityName, testLanguageCode))
          .thenAnswer((_) async => const Left(NetworkFailure('Network error')));

      // Действие
      final result = await useCase(testCityName, testLanguageCode);

      // Проверка
      expect(result, isA<Left<Failure, Weather>>());
      result.fold(
        (failure) {
          expect(failure, isA<NetworkFailure>());
          expect(failure.toString(), contains('Network error'));
        },
        (weather) => fail('Не должен возвращать погоду'),
      );
      verify(mockRepository.getCurrentWeather(testCityName, testLanguageCode)).called(1);
    });
  });
}
