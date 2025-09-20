import 'package:freezed_annotation/freezed_annotation.dart';

part 'city_model.freezed.dart';
part 'city_model.g.dart';

@freezed
class CityData with _$CityData {
  const factory CityData({
    required String name,
    required String iataCode,
    required String stateCode,
    required String countryCode,
    required double latitude,
    required double longitude,
  }) = _CityData;

  factory CityData.fromJson(Map<String, dynamic> json) => _$CityDataFromJson(json);
}
