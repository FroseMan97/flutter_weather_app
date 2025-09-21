import 'package:weather_domain/weather_domain.dart';
import '../models/city_model.dart';

class CityMapper {
  City toEntity(LocationData locationData) {    
    return City(
      name: _cleanName(locationData.name ?? ''),
      countryCode: locationData.address?.countryCode ?? '',
      iataCode: locationData.iataCode ?? '',
      stateCode: locationData.address?.stateCode ?? '',
      latitude: locationData.geoCode?.latitude ?? 0.0,
      longitude: locationData.geoCode?.longitude ?? 0.0,
    );
  }

  String _cleanName(String name) {
    // Убираем лишние запятые и пробелы из названия города
    return name.replaceAll(RegExp(r',\s*$'), '').trim();
  }
}

