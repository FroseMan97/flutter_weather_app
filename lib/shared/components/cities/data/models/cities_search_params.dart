import 'package:freezed_annotation/freezed_annotation.dart';

part 'cities_search_params.freezed.dart';

@freezed
class CitiesSearchParams with _$CitiesSearchParams {
  const factory CitiesSearchParams({
    required String query,
    @Default(10) int maxResults,
  }) = _CitiesSearchParams;
}
