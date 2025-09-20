import 'package:injectable/injectable.dart';
import '../../domain/entities/city.dart';
import '../models/city_model.dart';

@injectable
class CityMapper {
  City toEntity(CityData data) {
    return City(
      name: data.name ?? '',
      countryCode: data.address?.countryCode ?? '',
      iataCode: data.iataCode,
      stateCode: data.address?.stateCode,
      latitude: data.geoCode?.latitude ?? 0.0,
      longitude: data.geoCode?.longitude ?? 0.0,
    );
  }

  CityData toModel(City entity) {
    return CityData(
      type: 'location',
      subType: 'city',
      name: entity.name,
      iataCode: entity.iataCode,
      address: Address(
        countryCode: entity.countryCode,
        stateCode: entity.stateCode,
      ),
      geoCode: GeoCode(
        latitude: entity.latitude,
        longitude: entity.longitude,
      ),
    );
  }
}
