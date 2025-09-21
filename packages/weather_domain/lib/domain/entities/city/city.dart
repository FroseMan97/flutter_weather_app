import 'package:freezed_annotation/freezed_annotation.dart';

part 'city.freezed.dart';

@freezed
class City with _$City {
  const factory City({
    required String name,
    required String countryCode,
    required String iataCode,
    required String stateCode,
    required double latitude,
    required double longitude,
  }) = _City;
}


