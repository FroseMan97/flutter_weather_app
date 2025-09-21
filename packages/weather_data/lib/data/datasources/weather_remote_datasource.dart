import '../models/weather_model.dart' as model;
import '../../api/weather_api.dart';

abstract class WeatherRemoteDataSource {
  Future<model.WeatherModel> getCurrentWeather(String cityName, String lang);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final WeatherApi _weatherApi;

  WeatherRemoteDataSourceImpl(this._weatherApi);

  @override
  Future<model.WeatherModel> getCurrentWeather(String cityName, String lang) async {
    return await _weatherApi.getCurrentWeather(cityName, lang);
  }
}


