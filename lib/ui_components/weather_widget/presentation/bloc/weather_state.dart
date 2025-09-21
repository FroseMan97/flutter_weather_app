import 'package:flutter_weather_app/domain/entities/weather/weather.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_state.freezed.dart';

@freezed
class WeatherState with _$WeatherState {
  const factory WeatherState.initial() = WeatherInitial;
  const factory WeatherState.loading() = WeatherLoading;
  const factory WeatherState.loaded(Weather weather) = WeatherLoaded;
  const factory WeatherState.error(String message) = WeatherError;
}
