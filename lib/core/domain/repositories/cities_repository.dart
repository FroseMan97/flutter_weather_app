import 'package:dartz/dartz.dart';
import '../../errors/failures.dart';
import '../entities/city.dart';

abstract class CitiesRepository {
  Future<Either<Failure, List<City>>> searchCities(String query);
}
