import 'package:flutter_weather_app/core/localization/app_localization.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../domain/entities/city.dart';
import '../../domain/repositories/cities_repository.dart';
import '../datasources/cities_remote_datasource.dart';
import '../mappers/city_mapper.dart';

@injectable
class CitiesRepositoryImpl implements CitiesRepository {
  final CitiesRemoteDataSource _remoteDataSource;
  final CityMapper _cityMapper;

  CitiesRepositoryImpl(this._remoteDataSource, this._cityMapper);

  @override
  Future<List<City>> searchCities(String query) async {
    try {
      final cityDataList = await _remoteDataSource.searchCities(query);
      return cityDataList.map((data) => _cityMapper.toEntity(data)).toList();
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } on AuthException catch (e) {
      throw AuthFailure(e.message);
    } catch (e) {
      throw ServerFailure('${AppLocalization.unexpectedError}: $e');
    }
  }
}
