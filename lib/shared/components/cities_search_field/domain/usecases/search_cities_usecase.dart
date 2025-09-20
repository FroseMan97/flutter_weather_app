import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/errors/failures.dart';
import '../entities/city.dart';
import '../repositories/cities_repository.dart';

@injectable
class SearchCitiesUseCase {
  final CitiesRepository _repository;

  SearchCitiesUseCase(this._repository);

  Future<Either<Failure, List<City>>> call(String query) async {
    // Валидация на уровне домена
    if (query.isEmpty) {
      return const Left(ValidationFailure('Query cannot be empty'));
    }

    if (query.length < 3) {
      return const Left(ValidationFailure('Query must be at least 3 characters'));
    }

    // Проверяем, что query содержит только буквы
    final validQueryPattern = RegExp(r'^[a-zA-Zа-яА-Я\s]+$');
    if (!validQueryPattern.hasMatch(query.trim())) {
      return const Left(ValidationFailure('Query can only contain letters and spaces'));
    }

    return await _repository.searchCities(query);
  }
}

