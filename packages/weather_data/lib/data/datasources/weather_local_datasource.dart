import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/weather_model.dart' as model;

abstract class WeatherLocalDataSource {
  Future<model.WeatherModel?> getCachedWeather(String cityName);
  Future<void> cacheWeather(String cityName, model.WeatherModel weather);
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences _prefs;

  WeatherLocalDataSourceImpl(this._prefs);

  @override
  Future<model.WeatherModel?> getCachedWeather(String cityName) async {
    final cachedData = _prefs.getString('weather_$cityName');
    if (cachedData != null) {
      return model.WeatherModel.fromJson(json.decode(cachedData));
    }
    return null;
  }

  @override
  Future<void> cacheWeather(String cityName, model.WeatherModel weather) async {
    await _prefs.setString('weather_$cityName', json.encode(weather.toJson()));
  }
}


