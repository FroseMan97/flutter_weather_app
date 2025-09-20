import 'package:injectable/injectable.dart';
import '../../domain/entities/weather.dart' as domain;
import '../models/weather_model.dart';

@injectable
class WeatherMapper {
  domain.Weather toEntity(WeatherModel model) {
    return domain.Weather(
      cityName: model.name ?? '',
      temperature: model.main?.temp ?? 0.0,
      description: model.weather?.isNotEmpty == true ? model.weather!.first.description ?? '' : '',
      icon: model.weather?.isNotEmpty == true ? model.weather!.first.icon ?? '' : '',
      feelsLike: model.main?.feelsLike ?? 0.0,
      humidity: model.main?.humidity ?? 0,
      windSpeed: model.wind?.speed ?? 0.0,
      dateTime: model.dt != null 
        ? DateTime.fromMillisecondsSinceEpoch(model.dt! * 1000)
        : DateTime.now(),
    );
  }

  WeatherModel toModel(domain.Weather entity) {
    return WeatherModel(
      coord: Coord(lon: 0.0, lat: 0.0), // Placeholder
      weather: [
        Weather(
          id: 0,
          main: 'Unknown',
          description: entity.description,
          icon: entity.icon,
        )
      ],
      base: 'stations',
      main: Main(
        temp: entity.temperature,
        feelsLike: entity.feelsLike,
        tempMin: entity.temperature,
        tempMax: entity.temperature,
        pressure: 1013,
        humidity: entity.humidity,
      ),
      visibility: 10000,
      wind: Wind(
        speed: entity.windSpeed,
        deg: 0,
      ),
      clouds: Clouds(all: 0),
      dt: entity.dateTime.millisecondsSinceEpoch ~/ 1000,
      sys: Sys(
        type: 1,
        id: 0,
        country: '',
        sunrise: 0,
        sunset: 0,
      ),
      timezone: 0,
      id: 0,
      name: entity.cityName,
      cod: 200,
    );
  }
}
