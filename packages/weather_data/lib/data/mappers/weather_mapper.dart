import 'package:weather_domain/weather_domain.dart';
import '../models/weather_model.dart' as model;

class WeatherMapper {
  Weather toEntity(model.WeatherModel model) {
    return Weather(
      cityName: model.name ?? '',
      temperature: model.main?.temp ?? 0.0,
      description: model.weather?.isNotEmpty == true ? model.weather!.first.description ?? '' : '',
      icon: model.weather?.isNotEmpty == true ? model.weather!.first.icon ?? '' : '',
      feelsLike: model.main?.feelsLike ?? 0.0,
      humidity: model.main?.humidity ?? 0,
      windSpeed: model.wind?.speed ?? 0.0,
      dateTime: model.dt != null ? DateTime.fromMillisecondsSinceEpoch(model.dt! * 1000) : DateTime.now(),
    );
  }
}


