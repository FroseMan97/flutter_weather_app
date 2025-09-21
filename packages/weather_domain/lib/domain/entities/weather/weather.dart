import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather.freezed.dart';

@freezed
class Weather with _$Weather {
  const factory Weather({
    required String cityName,
    required double temperature,
    required String description,
    required String icon,
    required double feelsLike,
    required int humidity,
    required double windSpeed,
    required DateTime dateTime,
  }) = _Weather;
}


