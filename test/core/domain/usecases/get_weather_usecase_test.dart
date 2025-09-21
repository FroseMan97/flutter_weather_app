import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_weather_app/shared/domain/entities/weather.dart';
import 'package:flutter_weather_app/shared/domain/repositories/weather_repository.dart';
import 'package:flutter_weather_app/shared/domain/usecases/get_weather_usecase.dart';

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
          .thenAnswer((_) async => testWeather);

      // Act
      final result = await useCase(testCityName, testLang);

      // Assert
      expect(result, equals(testWeather));
      expect(result.cityName, equals('London'));
      expect(result.temperature, equals(20.0));
      verify(mockRepository.getCurrentWeather(testCityName, testLang));
      verifyNoMoreInteractions(mockRepository);
    });

    test('должен выбрасывать ArgumentError при пустом названии города', () async {
      // Act & Assert
      expect(
        () => useCase('', testLang),
        throwsA(isA<ArgumentError>().having(
          (e) => e.message,
          'message',
          'City name cannot be empty.',
        )),
      );
      verifyNever(mockRepository.getCurrentWeather(any, any));
    });

    test('должен принимать пустой язык и передавать в репозиторий', () async {
      // Arrange
      when(mockRepository.getCurrentWeather(testCityName, ''))
          .thenAnswer((_) async => testWeather);

      // Act
      final result = await useCase(testCityName, '');

      // Assert
      expect(result, equals(testWeather));
      verify(mockRepository.getCurrentWeather(testCityName, ''));
    });

    test('должен принимать валидные названия городов', () async {
      // Arrange
      const validCityName = 'New York';
      when(mockRepository.getCurrentWeather(validCityName, testLang))
          .thenAnswer((_) async => testWeather);

      // Act
      final result = await useCase(validCityName, testLang);

      // Assert
      expect(result, equals(testWeather));
      verify(mockRepository.getCurrentWeather(validCityName, testLang));
    });

    test('должен принимать названия городов с пробелами', () async {
      // Arrange
      const cityNameWithSpaces = 'San Francisco';
      when(mockRepository.getCurrentWeather(cityNameWithSpaces, testLang))
          .thenAnswer((_) async => testWeather);

      // Act
      final result = await useCase(cityNameWithSpaces, testLang);

      // Assert
      expect(result, equals(testWeather));
      verify(mockRepository.getCurrentWeather(cityNameWithSpaces, testLang));
    });

    test('должен принимать названия городов с кириллицей', () async {
      // Arrange
      const cyrillicCityName = 'Москва';
      when(mockRepository.getCurrentWeather(cyrillicCityName, testLang))
          .thenAnswer((_) async => testWeather);

      // Act
      final result = await useCase(cyrillicCityName, testLang);

      // Assert
      expect(result, equals(testWeather));
      verify(mockRepository.getCurrentWeather(cyrillicCityName, testLang));
    });

    test('должен пробрасывать ошибку репозитория', () async {
      // Arrange
      when(mockRepository.getCurrentWeather(testCityName, testLang))
          .thenThrow(Exception('Ошибка сервера'));

      // Act & Assert
      expect(
        () => useCase(testCityName, testLang),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Ошибка сервера'),
        )),
      );
      verify(mockRepository.getCurrentWeather(testCityName, testLang));
    });
  });
}