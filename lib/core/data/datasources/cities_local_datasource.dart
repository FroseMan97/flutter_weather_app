import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/city_model.dart';

abstract class CitiesLocalDataSource {
  Future<List<CityData>> getCachedCities(String query);
  Future<void> cacheCities(String query, List<CityData> cities);
  Future<void> clearCache();
}

@injectable
class CitiesLocalDataSourceImpl implements CitiesLocalDataSource {
  final SharedPreferences _sharedPreferences;
  static const String _citiesCacheKey = 'cached_cities';
  static const int _maxCacheSize = 50; // Максимум 50 запросов в кеше

  CitiesLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<List<CityData>> getCachedCities(String query) async {
    final cacheKey = '${_citiesCacheKey}_${query.toLowerCase()}';
    final cachedData = _sharedPreferences.getString(cacheKey);

    if (cachedData != null) {
      final List<dynamic> jsonList = json.decode(cachedData);
      return jsonList.map((json) => CityData.fromJson(json)).toList();
    }

    return [];
  }

  @override
  Future<void> cacheCities(String query, List<CityData> cities) async {
    final cacheKey = '${_citiesCacheKey}_${query.toLowerCase()}';
    final jsonString = json.encode(cities.map((city) => city.toJson()).toList());

    await _sharedPreferences.setString(cacheKey, jsonString);

    // Очищаем старые записи, если кеш переполнен
    await _cleanOldCache();
  }

  @override
  Future<void> clearCache() async {
    final keys = _sharedPreferences.getKeys();
    final citiesKeys = keys.where((key) => key.startsWith(_citiesCacheKey));
    for (final key in citiesKeys) {
      await _sharedPreferences.remove(key);
    }
  }

  Future<void> _cleanOldCache() async {
    final keys = _sharedPreferences.getKeys();
    final citiesKeys = keys.where((key) => key.startsWith(_citiesCacheKey)).toList();

    if (citiesKeys.length > _maxCacheSize) {
      // Удаляем самые старые записи
      citiesKeys.sort((a, b) {
        // В данном случае просто удаляем произвольно
        return 0;
      });
      for (int i = 0; i < citiesKeys.length - _maxCacheSize; i++) {
        await _sharedPreferences.remove(citiesKeys[i]);
      }
    }
  }
}
