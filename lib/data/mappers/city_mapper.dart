import 'package:injectable/injectable.dart';
import '../../domain/entities/city/city.dart';
import '../models/city_model.dart';

@injectable
class CityMapper {
  City toEntity(CityData data) {
    return City(
      name: data.name,
      countryCode: data.countryCode,
      iataCode: data.iataCode,
      stateCode: data.stateCode,
      latitude: data.latitude,
      longitude: data.longitude,
    );
  }
}
