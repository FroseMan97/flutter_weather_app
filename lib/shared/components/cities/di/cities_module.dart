import 'package:injectable/injectable.dart';
import '../data/datasources/cities_remote_datasource.dart';
import '../data/repositories/cities_repository_impl.dart';
import '../domain/repositories/cities_repository.dart';

@module
abstract class CitiesModule {
  @injectable
  CitiesRepository citiesRepository(CitiesRepositoryImpl impl) => impl;
  
  @injectable
  CitiesRemoteDataSource citiesRemoteDataSource(CitiesRemoteDataSourceImpl impl) => impl;
}
