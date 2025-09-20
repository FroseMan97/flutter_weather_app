import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_weather_app/shared/components/weather/domain/entities/weather.dart';
import 'package:flutter_weather_app/shared/components/weather/domain/repositories/weather_repository.dart';
import 'package:flutter_weather_app/shared/components/weather/presentation/bloc/weather_cubit.dart';
import 'package:flutter_weather_app/shared/components/weather/presentation/bloc/weather_state.dart';

import 'weather_cubit_test.mocks.dart';

@GenerateMocks([WeatherRepository])
void main() {
  late MockWeatherRepository mockWeatherRepository;
  late WeatherCubit weatherCubit;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    weatherCubit = WeatherCubit(mockWeatherRepository);
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
          when(mockWeatherRepository.getCurrentWeather(testCityName, 'en'))
              .thenAnswer((_) async => testWeather);
          return weatherCubit;
        },
        act: (cubit) => cubit.getCurrentWeather(testCityName, 'en'),
        expect: () => [
          const WeatherState.loading(),
          WeatherState.loaded(testWeather),
        ],
        verify: (_) {
          verify(mockWeatherRepository.getCurrentWeather(testCityName, 'en')).called(1);
        },
      );

      blocTest<WeatherCubit, WeatherState>(
        'emits [WeatherLoading, WeatherError] when getCurrentWeather fails',
        build: () {
          when(mockWeatherRepository.getCurrentWeather(testCityName, 'en'))
              .thenThrow(Exception('Network error'));
          return weatherCubit;
        },
        act: (cubit) => cubit.getCurrentWeather(testCityName, 'en'),
        expect: () => [
          const WeatherState.loading(),
          const WeatherState.error('Exception: Network error'),
        ],
        verify: (_) {
          verify(mockWeatherRepository.getCurrentWeather(testCityName, 'en')).called(1);
        },
      );

      blocTest<WeatherCubit, WeatherState>(
        'emits [WeatherError] when city name is empty',
        build: () => weatherCubit,
        act: (cubit) => cubit.getCurrentWeather('', 'en'),
        expect: () => [
          const WeatherState.error('Пожалуйста, введите название города'),
        ],
        verify: (_) {
          verifyNever(mockWeatherRepository.getCurrentWeather(any, any));
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
