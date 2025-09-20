import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_search_params.freezed.dart';

@freezed
class WeatherSearchParams with _$WeatherSearchParams {
  const factory WeatherSearchParams({
    required String cityName,
    @Default('metric') String units,
    @Default('ru') String language,
  }) = _WeatherSearchParams;
}
