import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_weather_app/core/domain/entities/weather.dart';
import 'package:flutter_weather_app/core/domain/usecases/get_weather_usecase.dart';
import 'package:flutter_weather_app/shared/components/weather_widget/presentation/bloc/weather_cubit.dart';
import 'package:flutter_weather_app/shared/components/weather_widget/presentation/bloc/weather_state.dart';

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

        // Assert
        await expectLater(
          cubit.stream,
          emitsInOrder([
            const WeatherState.loading(),
            WeatherState.loaded(testWeather),
          ]),
        );
      });

      test('должен эмитить loaded состояние при успешном получении погоды', () async {
        // Arrange
        when(mockGetWeatherUseCase(testCityName, testLocale))
            .thenAnswer((_) async => testWeather);

        // Act
        cubit.getCurrentWeather(testCityName, testLocale);

        // Assert
        await expectLater(
          cubit.stream,
          emitsInOrder([
            const WeatherState.loading(),
            WeatherState.loaded(testWeather),
          ]),
        );
        verify(mockGetWeatherUseCase(testCityName, testLocale));
      });

      test('должен эмитить error состояние при ошибке', () async {
        // Arrange
        when(mockGetWeatherUseCase(testCityName, testLocale))
            .thenThrow(Exception('Ошибка сервера'));

        // Act
        cubit.getCurrentWeather(testCityName, testLocale);

        // Assert
        await expectLater(
          cubit.stream,
          emitsInOrder([
            const WeatherState.loading(),
            const WeatherState.error('Exception: Ошибка сервера'),
          ]),
        );
      });

      test('должен эмитить error состояние при NetworkException', () async {
        // Arrange
        when(mockGetWeatherUseCase(testCityName, testLocale))
            .thenThrow(Exception('Нет интернета'));

        // Act
        cubit.getCurrentWeather(testCityName, testLocale);

        // Assert
        await expectLater(
          cubit.stream,
          emitsInOrder([
            const WeatherState.loading(),
            const WeatherState.error('Exception: Нет интернета'),
          ]),
        );
      });

      test('должен эмитить error состояние при ArgumentError', () async {
        // Arrange
        when(mockGetWeatherUseCase(testCityName, testLocale))
            .thenThrow(ArgumentError('Название города не может быть пустым'));

        // Act
        cubit.getCurrentWeather(testCityName, testLocale);

        // Assert
        await expectLater(
          cubit.stream,
          emitsInOrder([
            const WeatherState.loading(),
            const WeatherState.error('ArgumentError: Название города не может быть пустым'),
          ]),
        );
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