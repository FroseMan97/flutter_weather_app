import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/city_model.dart';

abstract class CitiesLocalDataSource {
  Future<List<LocationData>> getCachedCities(String query);
  Future<void> cacheCities(String query, List<LocationData> cities);
}

class CitiesLocalDataSourceImpl implements CitiesLocalDataSource {
  final SharedPreferences _prefs;

  CitiesLocalDataSourceImpl(this._prefs);

  @override
  Future<List<LocationData>> getCachedCities(String query) async {
    final cachedData = _prefs.getString('cities_$query');
    if (cachedData != null) {
      final List<dynamic> jsonList = json.decode(cachedData);
      return jsonList.map((json) => LocationData.fromJson(json)).toList();
    }
    return [];
  }

  @override
  Future<void> cacheCities(String query, List<LocationData> cities) async {
    final jsonList = cities.map((city) => city.toJson()).toList();
    await _prefs.setString('cities_$query', json.encode(jsonList));
  }
}


