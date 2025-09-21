import '../entities/city.dart';

abstract class CitiesRepository {
  Future<List<City>> searchCities(String query);
}
