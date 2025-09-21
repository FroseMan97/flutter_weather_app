import 'package:weather_core/weather_core.dart';
import 'package:weather_domain/weather_domain.dart';
import '../datasources/cities_local_datasource.dart';
import '../datasources/cities_remote_datasource.dart';
import '../mappers/city_mapper.dart';

class CitiesRepositoryImpl implements CitiesRepository {
  final CitiesRemoteDataSource _remoteDataSource;
  final CitiesLocalDataSource _localDataSource;
  final CityMapper _cityMapper;

  CitiesRepositoryImpl(this._remoteDataSource, this._localDataSource, this._cityMapper);

  @override
  Future<List<City>> searchCities(String query) async {
    try {
      // Сначала проверяем кеш
      final cachedCities = await _localDataSource.getCachedCities(query);
      if (cachedCities.isNotEmpty) {
        return cachedCities.map((locationData) => _cityMapper.toEntity(locationData)).toList();
      }

      // Если в кеше нет, делаем запрос к API
      final citiesResponse = await _remoteDataSource.searchCities(query);
      final cities = (citiesResponse.data ?? []).map((locationData) => _cityMapper.toEntity(locationData)).toList();

      // Кешируем результат
      await _localDataSource.cacheCities(query, citiesResponse.data ?? []);

      return cities;
    } on NetworkException {
      // При сетевой ошибке пытаемся вернуть кешированные данные
      final cachedCities = await _localDataSource.getCachedCities(query);
      if (cachedCities.isNotEmpty) {
        return cachedCities.map((locationData) => _cityMapper.toEntity(locationData)).toList();
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}


