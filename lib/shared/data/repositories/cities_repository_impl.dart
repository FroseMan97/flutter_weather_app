import 'package:injectable/injectable.dart';
import '../../../core/errors/exceptions.dart';
import '../../domain/entities/city.dart';
import '../../domain/repositories/cities_repository.dart';
import '../datasources/cities_local_datasource.dart';
import '../datasources/cities_remote_datasource.dart';
import '../mappers/city_mapper.dart';

@injectable
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
        return cachedCities.map((data) => _cityMapper.toEntity(data)).toList();
      }

      // Если в кеше нет, делаем запрос к API
      final cityDataList = await _remoteDataSource.searchCities(query);
      final cities = cityDataList.map((data) => _cityMapper.toEntity(data)).toList();

      // Кешируем результат
      await _localDataSource.cacheCities(query, cityDataList);

      return cities;
    } on NetworkException {
      // При сетевой ошибке пытаемся вернуть кешированные данные
      final cachedCities = await _localDataSource.getCachedCities(query);
      if (cachedCities.isNotEmpty) {
        return cachedCities.map((data) => _cityMapper.toEntity(data)).toList();
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
