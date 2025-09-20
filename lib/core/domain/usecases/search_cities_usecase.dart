import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../errors/failures.dart';
import '../entities/city.dart';
import '../repositories/cities_repository.dart';

@injectable
class SearchCitiesUseCase {
  final CitiesRepository _repository;

  SearchCitiesUseCase(this._repository);

  Future<Either<Failure, List<City>>> call(String query) async {
    if (query.isEmpty || query.length < 3) {
      return const Left(ValidationFailure('Query must be at least 3 characters long.'));
    }
    final validQueryPattern = RegExp(r'^[a-zA-Zа-яА-Я\s]+$'); // Allow spaces
    if (!validQueryPattern.hasMatch(query.trim())) {
      return const Left(ValidationFailure('Query can only contain letters and spaces.'));
    }
    return await _repository.searchCities(query);
  }
}
