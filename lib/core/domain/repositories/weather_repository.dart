import 'package:dartz/dartz.dart';
import '../../errors/failures.dart';
import '../entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName, String lang);
}
