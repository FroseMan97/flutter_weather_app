import '../models/city_model.dart';
import '../../api/cities_api.dart';

abstract class CitiesRemoteDataSource {
  Future<CitiesResponse> searchCities(String query);
}

class CitiesRemoteDataSourceImpl implements CitiesRemoteDataSource {
  final CitiesApi _citiesApi;

  CitiesRemoteDataSourceImpl(this._citiesApi);

  @override
  Future<CitiesResponse> searchCities(String query) async {
    return await _citiesApi.searchCities(query);
  }
}


