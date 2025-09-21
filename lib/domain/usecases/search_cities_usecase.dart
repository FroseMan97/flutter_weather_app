import 'package:injectable/injectable.dart';
import '../entities/city/city.dart';
import '../repositories/cities_repository.dart';

@injectable
class SearchCitiesUseCase {
  final CitiesRepository _repository;

  SearchCitiesUseCase(this._repository);

  Future<List<City>> call(String query) async {
    if (query.isEmpty || query.length < 3) {
      throw ArgumentError('Query must be at least 3 characters long.');
    }
    final validQueryPattern = RegExp(r'^[a-zA-Zа-яА-Я\s]+$'); // Allow spaces
    if (!validQueryPattern.hasMatch(query.trim())) {
      throw ArgumentError('Query can only contain letters and spaces.');
    }
    return await _repository.searchCities(query);
  }
}
