import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/weather_model.dart';

abstract class WeatherLocalDataSource {
  Future<WeatherModel?> getCachedWeather(String cityName);
  Future<void> cacheWeather(String cityName, WeatherModel weather);
  Future<void> clearCache();
}

@injectable
class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences _sharedPreferences;
  static const String _weatherCacheKey = 'cached_weather';
  static const int _maxCacheSize = 20; // Максимум 20 городов в кеше
  static const Duration _cacheExpiration = Duration(hours: 1); // Кеш на 1 час

  WeatherLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<WeatherModel?> getCachedWeather(String cityName) async {
    final cacheKey = '${_weatherCacheKey}_${cityName.toLowerCase()}';
    final cachedData = _sharedPreferences.getString(cacheKey);
    
    if (cachedData != null) {
      final Map<String, dynamic> json = jsonDecode(cachedData);
      final timestamp = DateTime.fromMillisecondsSinceEpoch(json['timestamp']);
      
      // Проверяем, не истек ли кеш
      if (DateTime.now().difference(timestamp) < _cacheExpiration) {
        return WeatherModel.fromJson(json['weather']);
      } else {
        // Удаляем устаревший кеш
        await _sharedPreferences.remove(cacheKey);
      }
    }
    
    return null;
  }

  @override
  Future<void> cacheWeather(String cityName, WeatherModel weather) async {
    final cacheKey = '${_weatherCacheKey}_${cityName.toLowerCase()}';
    final data = {
      'weather': weather.toJson(),
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };
    
    await _sharedPreferences.setString(cacheKey, jsonEncode(data));
    
    // Очищаем старые записи, если кеш переполнен
    await _cleanOldCache();
  }

  @override
  Future<void> clearCache() async {
    final keys = _sharedPreferences.getKeys();
    final weatherKeys = keys.where((key) => key.startsWith(_weatherCacheKey));
    
    for (final key in weatherKeys) {
      await _sharedPreferences.remove(key);
    }
  }

  Future<void> _cleanOldCache() async {
    final keys = _sharedPreferences.getKeys();
    final weatherKeys = keys.where((key) => key.startsWith(_weatherCacheKey)).toList();
    
    if (weatherKeys.length > _maxCacheSize) {
      // Удаляем самые старые записи
      final keysToRemove = weatherKeys.take(weatherKeys.length - _maxCacheSize);
      for (final key in keysToRemove) {
        await _sharedPreferences.remove(key);
      }
    }
  }
}

