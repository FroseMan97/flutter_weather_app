import 'package:freezed_annotation/freezed_annotation.dart';

part 'city_model.freezed.dart';
part 'city_model.g.dart';

@freezed
class CityResponse with _$CityResponse {
  const factory CityResponse({
    List<CityData>? data,
    Meta? meta,
  }) = _CityResponse;

  factory CityResponse.fromJson(Map<String, dynamic> json) =>
      _$CityResponseFromJson(json);
}

@freezed
class CityData with _$CityData {
  const factory CityData({
    String? type,
    String? subType,
    String? name,
    String? iataCode,
    Address? address,
    GeoCode? geoCode,
  }) = _CityData;

  factory CityData.fromJson(Map<String, dynamic> json) =>
      _$CityDataFromJson(json);
}

@freezed
class Address with _$Address {
  const factory Address({
    String? countryCode,
    String? stateCode,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

@freezed
class GeoCode with _$GeoCode {
  const factory GeoCode({
    double? latitude,
    double? longitude,
  }) = _GeoCode;

  factory GeoCode.fromJson(Map<String, dynamic> json) =>
      _$GeoCodeFromJson(json);
}

@freezed
class Meta with _$Meta {
  const factory Meta({
    int? count,
    Links? links,
  }) = _Meta;

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}

@freezed
class Links with _$Links {
  const factory Links({
    String? self,
  }) = _Links;

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);
}

