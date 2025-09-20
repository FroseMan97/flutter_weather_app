import 'package:dartz/dartz.dart';
import '../../localization/app_localization.dart';
import 'package:injectable/injectable.dart';
import '../../errors/exceptions.dart';
import '../../errors/failures.dart';
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
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName, String lang) async {
    try {
      // Сначала проверяем кеш
      final cachedWeather = await _localDataSource.getCachedWeather(cityName);
      if (cachedWeather != null) {
        final weather = _weatherMapper.toEntity(cachedWeather);
        return Right(weather);
      }

      // Если в кеше нет, делаем запрос к API
      final weatherModel = await _remoteDataSource.getCurrentWeather(cityName, lang);
      final weather = _weatherMapper.toEntity(weatherModel);

      // Кешируем результат
      await _localDataSource.cacheWeather(cityName, weatherModel);

      return Right(weather);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      // При сетевой ошибке пытаемся вернуть кешированные данные
      final cachedWeather = await _localDataSource.getCachedWeather(cityName);
      if (cachedWeather != null) {
        final weather = _weatherMapper.toEntity(cachedWeather);
        return Right(weather);
      }
      return Left(NetworkFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('${AppLocalization.unexpectedError}: $e'));
    }
  }
}
