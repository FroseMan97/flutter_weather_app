import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../errors/failures.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

@injectable
class GetWeatherUseCase {
  final WeatherRepository _repository;

  GetWeatherUseCase(this._repository);

  Future<Either<Failure, Weather>> call(String cityName, String lang) async {
    if (cityName.isEmpty) {
      return const Left(ValidationFailure('City name cannot be empty.'));
    }
    return await _repository.getCurrentWeather(cityName, lang);
  }
}
