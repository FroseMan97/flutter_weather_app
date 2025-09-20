// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cities_search_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CitiesSearchParams {
  String get query => throw _privateConstructorUsedError;
  int get maxResults => throw _privateConstructorUsedError;

  /// Create a copy of CitiesSearchParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CitiesSearchParamsCopyWith<CitiesSearchParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CitiesSearchParamsCopyWith<$Res> {
  factory $CitiesSearchParamsCopyWith(
          CitiesSearchParams value, $Res Function(CitiesSearchParams) then) =
      _$CitiesSearchParamsCopyWithImpl<$Res, CitiesSearchParams>;
  @useResult
  $Res call({String query, int maxResults});
}

/// @nodoc
class _$CitiesSearchParamsCopyWithImpl<$Res, $Val extends CitiesSearchParams>
    implements $CitiesSearchParamsCopyWith<$Res> {
  _$CitiesSearchParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CitiesSearchParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? maxResults = null,
  }) {
    return _then(_value.copyWith(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      maxResults: null == maxResults
          ? _value.maxResults
          : maxResults // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CitiesSearchParamsImplCopyWith<$Res>
    implements $CitiesSearchParamsCopyWith<$Res> {
  factory _$$CitiesSearchParamsImplCopyWith(_$CitiesSearchParamsImpl value,
          $Res Function(_$CitiesSearchParamsImpl) then) =
      __$$CitiesSearchParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String query, int maxResults});
}

/// @nodoc
class __$$CitiesSearchParamsImplCopyWithImpl<$Res>
    extends _$CitiesSearchParamsCopyWithImpl<$Res, _$CitiesSearchParamsImpl>
    implements _$$CitiesSearchParamsImplCopyWith<$Res> {
  __$$CitiesSearchParamsImplCopyWithImpl(_$CitiesSearchParamsImpl _value,
      $Res Function(_$CitiesSearchParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of CitiesSearchParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? maxResults = null,
  }) {
    return _then(_$CitiesSearchParamsImpl(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      maxResults: null == maxResults
          ? _value.maxResults
          : maxResults // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$CitiesSearchParamsImpl implements _CitiesSearchParams {
  const _$CitiesSearchParamsImpl({required this.query, this.maxResults = 10});

  @override
  final String query;
  @override
  @JsonKey()
  final int maxResults;

  @override
  String toString() {
    return 'CitiesSearchParams(query: $query, maxResults: $maxResults)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CitiesSearchParamsImpl &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.maxResults, maxResults) ||
                other.maxResults == maxResults));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query, maxResults);

  /// Create a copy of CitiesSearchParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CitiesSearchParamsImplCopyWith<_$CitiesSearchParamsImpl> get copyWith =>
      __$$CitiesSearchParamsImplCopyWithImpl<_$CitiesSearchParamsImpl>(
          this, _$identity);
}

abstract class _CitiesSearchParams implements CitiesSearchParams {
  const factory _CitiesSearchParams(
      {required final String query,
      final int maxResults}) = _$CitiesSearchParamsImpl;

  @override
  String get query;
  @override
  int get maxResults;

  /// Create a copy of CitiesSearchParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CitiesSearchParamsImplCopyWith<_$CitiesSearchParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
