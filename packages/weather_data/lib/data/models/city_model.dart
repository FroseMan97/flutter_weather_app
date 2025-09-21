import 'package:freezed_annotation/freezed_annotation.dart';

part 'city_model.freezed.dart';
part 'city_model.g.dart';

@freezed
class CitiesResponse with _$CitiesResponse {
  const factory CitiesResponse({
    Meta? meta,
    List<LocationData>? data,
  }) = _CitiesResponse;

  factory CitiesResponse.fromJson(Map<String, dynamic> json) =>
      _$CitiesResponseFromJson(json);
}

@freezed
class Meta with _$Meta {
  const factory Meta({
    int? count,
    MetaLinks? links,
  }) = _Meta;

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}

@freezed
class MetaLinks with _$MetaLinks {
  const factory MetaLinks({
    String? self,
  }) = _MetaLinks;

  factory MetaLinks.fromJson(Map<String, dynamic> json) =>
      _$MetaLinksFromJson(json);
}

@freezed
class LocationData with _$LocationData {
  const factory LocationData({
    String? type,
    String? subType,
    String? name,
    String? iataCode,
    Address? address,
    GeoCode? geoCode,
  }) = _LocationData;

  factory LocationData.fromJson(Map<String, dynamic> json) =>
      _$LocationDataFromJson(json);
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
