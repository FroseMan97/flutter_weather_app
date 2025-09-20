import 'package:injectable/injectable.dart';
import '../api/weather_api.dart';
import '../models/weather_model.dart';
import '../models/weather_search_params.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName, String lang);
}

@injectable
class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final WeatherApi _weatherApi;

  WeatherRemoteDataSourceImpl(this._weatherApi);

  @override
  Future<WeatherModel> getCurrentWeather(String cityName, String lang) async {
    return await _weatherApi.getCurrentWeather(WeatherSearchParams(
      cityName: cityName,
      language: lang,
    ));
  }
}
