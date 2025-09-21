import 'package:injectable/injectable.dart';
import '../entities/weather/weather.dart';
import '../repositories/weather_repository.dart';

@injectable
class GetWeatherUseCase {
  final WeatherRepository _repository;

  GetWeatherUseCase(this._repository);

  Future<Weather> call(String cityName, String lang) async {
    if (cityName.isEmpty) {
      throw ArgumentError('City name cannot be empty.');
    }
    return await _repository.getCurrentWeather(cityName, lang);
  }
}
