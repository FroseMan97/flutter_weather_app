import 'package:flutter_weather_app/domain/entities/city/city.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cities_state.freezed.dart';

@freezed
class CitiesState with _$CitiesState {
  const factory CitiesState.initial() = CitiesInitial;
  const factory CitiesState.loading() = CitiesLoading;
  const factory CitiesState.loaded({
    required List<City> cities,
    @Default(false) bool showSuggestions,
  }) = CitiesLoaded;
  const factory CitiesState.error(String message) = CitiesError;
  const factory CitiesState.empty() = CitiesEmpty;
}
