import 'package:injectable/injectable.dart';
import '../../../core/errors/exceptions.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_local_datasource.dart';
import '../datasources/weather_remote_datasource.dart';
import '../mappers/weather_mapper.dart';

@injectable
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource _remoteDataSource;
  final WeatherLocalDataSource _localDataSource;
  final WeatherMapper _weatherMapper;

  WeatherRepositoryImpl(this._remoteDataSource, this._localDataSource, this._weatherMapper);

  @override
  Future<Weather> getCurrentWeather(String cityName, String lang) async {
    try {
      // Сначала проверяем кеш
      final cachedWeather = await _localDataSource.getCachedWeather(cityName);
      if (cachedWeather != null) {
        return _weatherMapper.toEntity(cachedWeather);
      }

      // Если в кеше нет, делаем запрос к API
      final weatherModel = await _remoteDataSource.getCurrentWeather(cityName, lang);
      final weather = _weatherMapper.toEntity(weatherModel);

      // Кешируем результат
      await _localDataSource.cacheWeather(cityName, weatherModel);

      return weather;
    } on NetworkException {
      // При сетевой ошибке пытаемся вернуть кешированные данные
      final cachedWeather = await _localDataSource.getCachedWeather(cityName);
      if (cachedWeather != null) {
        return _weatherMapper.toEntity(cachedWeather);
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
