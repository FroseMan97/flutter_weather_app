import 'package:injectable/injectable.dart';
import '../api/cities_api.dart';
import '../models/city_model.dart';
import '../models/cities_search_params.dart';

abstract class CitiesRemoteDataSource {
  Future<List<CityData>> searchCities(String query);
}

@injectable
class CitiesRemoteDataSourceImpl implements CitiesRemoteDataSource {
  final CitiesApi _citiesApi;

  CitiesRemoteDataSourceImpl(this._citiesApi);

  @override
  Future<List<CityData>> searchCities(String query) async {
    return await _citiesApi.searchCities(CitiesSearchParams(query: query));
  }
}
