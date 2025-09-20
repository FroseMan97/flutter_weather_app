import 'package:flutter_weather_app/core/localization/app_localization.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_remote_datasource.dart';
import '../mappers/weather_mapper.dart';

@injectable
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource _remoteDataSource;
  final WeatherMapper _weatherMapper;

  WeatherRepositoryImpl(this._remoteDataSource, this._weatherMapper);

  @override
  Future<Weather> getCurrentWeather(String cityName, String lang) async {
    try {
      final weatherModel = await _remoteDataSource.getCurrentWeather(cityName, lang);
      return _weatherMapper.toEntity(weatherModel);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } on CacheException catch (e) {
      throw CacheFailure(e.message);
    } catch (e) {
      throw ServerFailure('${AppLocalization.unexpectedError}: $e');
    }
  }
}
