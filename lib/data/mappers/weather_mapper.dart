import 'package:injectable/injectable.dart';
import '../../domain/entities/weather/weather.dart';
import '../models/weather_model.dart' as model;

@injectable
class WeatherMapper {
  Weather toEntity(model.WeatherModel model) {
    return Weather(
      cityName: model.name,
      temperature: model.main.temp,
      description: model.weather.first.description,
      icon: model.weather.first.icon,
      feelsLike: model.main.feelsLike,
      humidity: model.main.humidity,
      windSpeed: model.wind.speed,
      dateTime: DateTime.fromMillisecondsSinceEpoch(model.dt * 1000),
    );
  }
}
