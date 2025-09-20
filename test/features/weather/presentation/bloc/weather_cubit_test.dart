import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/errors/failures.dart';
import 'package:flutter_weather_app/shared/components/weather/domain/entities/weather.dart';
import 'package:flutter_weather_app/shared/components/weather/domain/usecases/get_weather_usecase.dart';
import 'package:flutter_weather_app/shared/components/weather/presentation/bloc/weather_cubit.dart';
import 'package:flutter_weather_app/shared/components/weather/presentation/bloc/weather_state.dart';

import 'weather_cubit_test.mocks.dart';

@GenerateMocks([GetWeatherUseCase])
void main() {
  late MockGetWeatherUseCase mockGetWeatherUseCase;
  late WeatherCubit weatherCubit;

  setUp(() {
    mockGetWeatherUseCase = MockGetWeatherUseCase();
    weatherCubit = WeatherCubit(mockGetWeatherUseCase);
  });

  tearDown(() {
    weatherCubit.close();
  });

  group('WeatherCubit', () {
    test('initial state should be WeatherInitial', () {
      expect(weatherCubit.state, equals(const WeatherState.initial()));
    });

    group('getCurrentWeather', () {
      const testCityName = 'London';
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

      blocTest<WeatherCubit, WeatherState>(
        'emits [WeatherLoading, WeatherLoaded] when getCurrentWeather succeeds',
        build: () {
          when(mockGetWeatherUseCase(testCityName, 'en'))
              .thenAnswer((_) async => Right(testWeather));
          return weatherCubit;
        },
        act: (cubit) => cubit.getCurrentWeather(testCityName, 'en'),
        expect: () => [
          const WeatherState.loading(),
          WeatherState.loaded(testWeather),
        ],
        verify: (_) {
          verify(mockGetWeatherUseCase(testCityName, 'en')).called(1);
        },
      );

      blocTest<WeatherCubit, WeatherState>(
        'emits [WeatherLoading, WeatherError] when getCurrentWeather fails',
        build: () {
          when(mockGetWeatherUseCase(testCityName, 'en'))
              .thenAnswer((_) async => const Left(NetworkFailure('Network error')));
          return weatherCubit;
        },
        act: (cubit) => cubit.getCurrentWeather(testCityName, 'en'),
        expect: () => [
          const WeatherState.loading(),
          const WeatherState.error('Network error: Network error'),
        ],
        verify: (_) {
          verify(mockGetWeatherUseCase(testCityName, 'en')).called(1);
        },
      );

      blocTest<WeatherCubit, WeatherState>(
        'emits [WeatherLoading, WeatherError] when city name is empty',
        build: () {
          when(mockGetWeatherUseCase('', 'en'))
              .thenAnswer((_) async => const Left(ValidationFailure('City name cannot be empty')));
          return weatherCubit;
        },
        act: (cubit) => cubit.getCurrentWeather('', 'en'),
        expect: () => [
          const WeatherState.loading(),
          const WeatherState.error('Validation error: City name cannot be empty'),
        ],
        verify: (_) {
          verify(mockGetWeatherUseCase('', 'en')).called(1);
        },
      );
    });

    group('clearWeather', () {
      blocTest<WeatherCubit, WeatherState>(
        'emits [WeatherInitial] when clearWeather is called',
        build: () => weatherCubit,
        act: (cubit) => cubit.clearWeather(),
        expect: () => [
          const WeatherState.initial(),
        ],
      );
    });
  });
}
