import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/errors/failures.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

@injectable
class GetWeatherUseCase {
  final WeatherRepository _repository;

  GetWeatherUseCase(this._repository);

  Future<Either<Failure, Weather>> call(String cityName, String languageCode) async {
    // Валидация на уровне домена
    if (cityName.isEmpty) {
      return const Left(ValidationFailure('City name cannot be empty'));
    }

    if (cityName.length < 2) {
      return const Left(ValidationFailure('City name must be at least 2 characters'));
    }

    // Проверяем, что cityName содержит только буквы и пробелы
    final validCityPattern = RegExp(r'^[a-zA-Zа-яА-Я\s]+$');
    if (!validCityPattern.hasMatch(cityName.trim())) {
      return const Left(ValidationFailure('City name can only contain letters and spaces'));
    }

    // Валидация language code
    if (languageCode.isEmpty) {
      return const Left(ValidationFailure('Language code cannot be empty'));
    }

    final validLanguagePattern = RegExp(r'^[a-z]{2}$');
    if (!validLanguagePattern.hasMatch(languageCode)) {
      return const Left(ValidationFailure('Language code must be 2 lowercase letters'));
    }

    return await _repository.getCurrentWeather(cityName, languageCode);
  }
}

