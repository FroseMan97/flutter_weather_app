// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_search_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WeatherSearchParams {
  String get cityName => throw _privateConstructorUsedError;
  String get units => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;

  /// Create a copy of WeatherSearchParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeatherSearchParamsCopyWith<WeatherSearchParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherSearchParamsCopyWith<$Res> {
  factory $WeatherSearchParamsCopyWith(
          WeatherSearchParams value, $Res Function(WeatherSearchParams) then) =
      _$WeatherSearchParamsCopyWithImpl<$Res, WeatherSearchParams>;
  @useResult
  $Res call({String cityName, String units, String language});
}

/// @nodoc
class _$WeatherSearchParamsCopyWithImpl<$Res, $Val extends WeatherSearchParams>
    implements $WeatherSearchParamsCopyWith<$Res> {
  _$WeatherSearchParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeatherSearchParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cityName = null,
    Object? units = null,
    Object? language = null,
  }) {
    return _then(_value.copyWith(
      cityName: null == cityName
          ? _value.cityName
          : cityName // ignore: cast_nullable_to_non_nullable
              as String,
      units: null == units
          ? _value.units
          : units // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeatherSearchParamsImplCopyWith<$Res>
    implements $WeatherSearchParamsCopyWith<$Res> {
  factory _$$WeatherSearchParamsImplCopyWith(_$WeatherSearchParamsImpl value,
          $Res Function(_$WeatherSearchParamsImpl) then) =
      __$$WeatherSearchParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String cityName, String units, String language});
}

/// @nodoc
class __$$WeatherSearchParamsImplCopyWithImpl<$Res>
    extends _$WeatherSearchParamsCopyWithImpl<$Res, _$WeatherSearchParamsImpl>
    implements _$$WeatherSearchParamsImplCopyWith<$Res> {
  __$$WeatherSearchParamsImplCopyWithImpl(_$WeatherSearchParamsImpl _value,
      $Res Function(_$WeatherSearchParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of WeatherSearchParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cityName = null,
    Object? units = null,
    Object? language = null,
  }) {
    return _then(_$WeatherSearchParamsImpl(
      cityName: null == cityName
          ? _value.cityName
          : cityName // ignore: cast_nullable_to_non_nullable
              as String,
      units: null == units
          ? _value.units
          : units // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$WeatherSearchParamsImpl implements _WeatherSearchParams {
  const _$WeatherSearchParamsImpl(
      {required this.cityName, this.units = 'metric', this.language = 'ru'});

  @override
  final String cityName;
  @override
  @JsonKey()
  final String units;
  @override
  @JsonKey()
  final String language;

  @override
  String toString() {
    return 'WeatherSearchParams(cityName: $cityName, units: $units, language: $language)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherSearchParamsImpl &&
            (identical(other.cityName, cityName) ||
                other.cityName == cityName) &&
            (identical(other.units, units) || other.units == units) &&
            (identical(other.language, language) ||
                other.language == language));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cityName, units, language);

  /// Create a copy of WeatherSearchParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherSearchParamsImplCopyWith<_$WeatherSearchParamsImpl> get copyWith =>
      __$$WeatherSearchParamsImplCopyWithImpl<_$WeatherSearchParamsImpl>(
          this, _$identity);
}

abstract class _WeatherSearchParams implements WeatherSearchParams {
  const factory _WeatherSearchParams(
      {required final String cityName,
      final String units,
      final String language}) = _$WeatherSearchParamsImpl;

  @override
  String get cityName;
  @override
  String get units;
  @override
  String get language;

  /// Create a copy of WeatherSearchParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeatherSearchParamsImplCopyWith<_$WeatherSearchParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
