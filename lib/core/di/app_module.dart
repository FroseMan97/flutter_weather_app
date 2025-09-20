import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/dio_client.dart';
import '../../shared/components/cities_search_field/domain/repositories/cities_repository.dart';
import '../../shared/components/cities_search_field/data/repositories/cities_repository_impl.dart';
import '../../shared/components/cities_search_field/data/datasources/cities_remote_datasource.dart';
import '../../shared/components/cities_search_field/data/datasources/cities_local_datasource.dart';
import '../../shared/components/weather_widget/domain/repositories/weather_repository.dart';
import '../../shared/components/weather_widget/data/repositories/weather_repository_impl.dart';
import '../../shared/components/weather_widget/data/datasources/weather_remote_datasource.dart';
import '../../shared/components/weather_widget/data/datasources/weather_local_datasource.dart';

@module
abstract class AppModule {
  @singleton
  Dio get dio {
    final dioClient = DioClient();
    dioClient.initialize();
    return dioClient.dio;
  }

  @preResolve
  @singleton
  Future<SharedPreferences> get sharedPreferences => SharedPreferences.getInstance();

  @singleton
  CitiesRepository citiesRepository(CitiesRepositoryImpl impl) => impl;

  @singleton
  WeatherRepository weatherRepository(WeatherRepositoryImpl impl) => impl;

  @singleton
  CitiesRemoteDataSource citiesRemoteDataSource(CitiesRemoteDataSourceImpl impl) => impl;

  @singleton
  CitiesLocalDataSource citiesLocalDataSource(CitiesLocalDataSourceImpl impl) => impl;

  @singleton
  WeatherRemoteDataSource weatherRemoteDataSource(WeatherRemoteDataSourceImpl impl) => impl;

  @singleton
  WeatherLocalDataSource weatherLocalDataSource(WeatherLocalDataSourceImpl impl) => impl;
}
