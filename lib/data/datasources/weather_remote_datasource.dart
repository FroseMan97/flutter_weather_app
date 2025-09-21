import 'package:injectable/injectable.dart';
import '../../core/api/weather_api.dart';
import '../models/weather_model.dart' as model;

abstract class WeatherRemoteDataSource {
  Future<model.WeatherModel> getCurrentWeather(String cityName, String lang);
}

@injectable
class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final WeatherApi _weatherApi;

  WeatherRemoteDataSourceImpl(this._weatherApi);

  @override
  Future<model.WeatherModel> getCurrentWeather(String cityName, String lang) async {
    return await _weatherApi.getCurrentWeather(cityName, lang);
  }
}
