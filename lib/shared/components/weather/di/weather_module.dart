import 'package:injectable/injectable.dart';
import '../data/datasources/weather_remote_datasource.dart';
import '../data/repositories/weather_repository_impl.dart';
import '../domain/repositories/weather_repository.dart';

@module
abstract class WeatherModule {
  @injectable
  WeatherRepository weatherRepository(WeatherRepositoryImpl impl) => impl;
  
  @injectable
  WeatherRemoteDataSource weatherRemoteDataSource(WeatherRemoteDataSourceImpl impl) => impl;
}
