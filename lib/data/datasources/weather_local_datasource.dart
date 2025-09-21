import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/weather_model.dart' as model;

abstract class WeatherLocalDataSource {
  Future<model.WeatherModel?> getCachedWeather(String cityName);
  Future<void> cacheWeather(String cityName, model.WeatherModel weather);
  Future<void> clearCache();
}

@injectable
class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences _sharedPreferences;
  static const String _weatherCacheKey = 'cached_weather';
  static const Duration _cacheTtl = Duration(minutes: 30); // Время жизни кеша

  WeatherLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<model.WeatherModel?> getCachedWeather(String cityName) async {
    final cacheKey = '${_weatherCacheKey}_${cityName.toLowerCase()}';
    final cachedData = _sharedPreferences.getString(cacheKey);

    if (cachedData != null) {
      final Map<String, dynamic> jsonMap = json.decode(cachedData);
      final timestamp = DateTime.parse(jsonMap['timestamp']);
      if (DateTime.now().difference(timestamp) < _cacheTtl) {
        return model.WeatherModel.fromJson(jsonMap['data']);
      } else {
        // Кеш устарел, удаляем
        await _sharedPreferences.remove(cacheKey);
      }
    }
    return null;
  }

  @override
  Future<void> cacheWeather(String cityName, model.WeatherModel weather) async {
    final cacheKey = '${_weatherCacheKey}_${cityName.toLowerCase()}';
    final dataToCache = {
      'timestamp': DateTime.now().toIso8601String(),
      'data': weather.toJson(),
    };
    final jsonString = json.encode(dataToCache);
    await _sharedPreferences.setString(cacheKey, jsonString);
  }

  @override
  Future<void> clearCache() async {
    final keys = _sharedPreferences.getKeys();
    final weatherKeys = keys.where((key) => key.startsWith(_weatherCacheKey));
    for (final key in weatherKeys) {
      await _sharedPreferences.remove(key);
    }
  }
}
