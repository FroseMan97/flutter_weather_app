import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_weather_app/domain/entities/weather/weather.dart';
import 'package:flutter_weather_app/domain/usecases/get_weather_usecase.dart';
import 'package:flutter_weather_app/core/errors/exceptions.dart';
import 'package:flutter_weather_app/ui_components/weather_widget/presentation/bloc/weather_cubit.dart';
import 'package:flutter_weather_app/ui_components/weather_widget/presentation/bloc/weather_state.dart';

import 'weather_cubit_test.mocks.dart';

@GenerateMocks([GetWeatherUseCase])
void main() {
  late WeatherCubit cubit;
  late MockGetWeatherUseCase mockGetWeatherUseCase;

  setUp(() {
    mockGetWeatherUseCase = MockGetWeatherUseCase();
    cubit = WeatherCubit(mockGetWeatherUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('WeatherCubit', () {
    test('должен начинать с initial состояния', () {
      expect(cubit.state, equals(const WeatherState.initial()));
    });

    group('getCurrentWeather', () {
      const testCityName = 'London';
      const testLocale = 'ru';
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

      test('должен эмитить loading состояние при запросе погоды', () async {
        // Arrange
        when(mockGetWeatherUseCase(testCityName, testLocale))
            .thenAnswer((_) async => testWeather);

        // Act
        cubit.getCurrentWeather(testCityName, testLocale);

        // Assert - проверяем, что состояние сразу стало loading
        expect(cubit.state, equals(const WeatherState.loading()));
        
        // Ждем завершения асинхронной операции
        await Future.delayed(const Duration(milliseconds: 100));
        
        // Проверяем, что состояние стало loaded
        expect(cubit.state, equals(WeatherState.loaded(testWeather)));
      });

      test('должен эмитить loaded состояние при успешном получении погоды', () async {
        // Arrange
        when(mockGetWeatherUseCase(testCityName, testLocale))
            .thenAnswer((_) async => testWeather);

        // Act
        await cubit.getCurrentWeather(testCityName, testLocale);

        // Assert
        expect(cubit.state, equals(WeatherState.loaded(testWeather)));
        verify(mockGetWeatherUseCase.call(testCityName, testLocale));
      });

      test('должен эмитить error состояние при ошибке', () async {
        // Arrange
        when(mockGetWeatherUseCase(testCityName, testLocale))
            .thenThrow(Exception('Ошибка сервера'));

        // Act
        await cubit.getCurrentWeather(testCityName, testLocale);

        // Assert
        expect(cubit.state, equals(const WeatherState.error('Exception: Ошибка сервера')));
      });

      test('должен эмитить error состояние при NetworkException', () async {
        // Arrange
        when(mockGetWeatherUseCase(testCityName, testLocale))
            .thenThrow(const NetworkException('Нет интернета'));

        // Act
        await cubit.getCurrentWeather(testCityName, testLocale);

        // Assert
        expect(cubit.state, equals(const WeatherState.error('Network error: Нет интернета')));
      });

      test('должен эмитить error состояние при ArgumentError', () async {
        // Arrange
        when(mockGetWeatherUseCase(testCityName, testLocale))
            .thenThrow(ArgumentError('Название города не может быть пустым'));

        // Act
        await cubit.getCurrentWeather(testCityName, testLocale);

        // Assert
        expect(cubit.state, equals(const WeatherState.error('Invalid argument(s): Название города не может быть пустым')));
      });
    });

    group('clearWeather', () {
      test('должен эмитить initial состояние', () {
        // Act
        cubit.clearWeather();

        // Assert
        expect(cubit.state, equals(const WeatherState.initial()));
      });
    });

    group('getWeatherIconUrl', () {
      test('должен возвращать правильный URL для иконки погоды', () {
        // Arrange
        const iconCode = '01d';

        // Act
        final url = cubit.getWeatherIconUrl(iconCode);

        // Assert
        expect(url, equals('https://openweathermap.org/img/wn/$iconCode@2x.png'));
      });

      test('должен возвращать правильный URL для разных иконок', () {
        // Arrange
        const iconCode = '10n';

        // Act
        final url = cubit.getWeatherIconUrl(iconCode);

        // Assert
        expect(url, equals('https://openweathermap.org/img/wn/$iconCode@2x.png'));
      });
    });
  });
}