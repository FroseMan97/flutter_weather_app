import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_domain/weather_domain.dart';

part 'weather_state.freezed.dart';

@freezed
class WeatherState with _$WeatherState {
  const factory WeatherState.initial() = WeatherInitial;
  const factory WeatherState.loading() = WeatherLoading;
  const factory WeatherState.loaded(Weather weather) = WeatherLoaded;
  const factory WeatherState.error(
    String message, {
    String? cityName,
    String? locale,
  }) = WeatherError;
}
