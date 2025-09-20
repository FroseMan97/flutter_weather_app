// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'access_token_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AccessTokenModel _$AccessTokenModelFromJson(Map<String, dynamic> json) {
  return _AccessTokenModel.fromJson(json);
}

/// @nodoc
mixin _$AccessTokenModel {
  String? get accessToken => throw _privateConstructorUsedError;
  String? get tokenType => throw _privateConstructorUsedError;
  int? get expiresIn => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  /// Serializes this AccessTokenModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AccessTokenModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccessTokenModelCopyWith<AccessTokenModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccessTokenModelCopyWith<$Res> {
  factory $AccessTokenModelCopyWith(
          AccessTokenModel value, $Res Function(AccessTokenModel) then) =
      _$AccessTokenModelCopyWithImpl<$Res, AccessTokenModel>;
  @useResult
  $Res call(
      {String? accessToken,
      String? tokenType,
      int? expiresIn,
      DateTime? expiresAt});
}

/// @nodoc
class _$AccessTokenModelCopyWithImpl<$Res, $Val extends AccessTokenModel>
    implements $AccessTokenModelCopyWith<$Res> {
  _$AccessTokenModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccessTokenModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = freezed,
    Object? tokenType = freezed,
    Object? expiresIn = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_value.copyWith(
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenType: freezed == tokenType
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresIn: freezed == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as int?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccessTokenModelImplCopyWith<$Res>
    implements $AccessTokenModelCopyWith<$Res> {
  factory _$$AccessTokenModelImplCopyWith(_$AccessTokenModelImpl value,
          $Res Function(_$AccessTokenModelImpl) then) =
      __$$AccessTokenModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? accessToken,
      String? tokenType,
      int? expiresIn,
      DateTime? expiresAt});
}

/// @nodoc
class __$$AccessTokenModelImplCopyWithImpl<$Res>
    extends _$AccessTokenModelCopyWithImpl<$Res, _$AccessTokenModelImpl>
    implements _$$AccessTokenModelImplCopyWith<$Res> {
  __$$AccessTokenModelImplCopyWithImpl(_$AccessTokenModelImpl _value,
      $Res Function(_$AccessTokenModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccessTokenModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = freezed,
    Object? tokenType = freezed,
    Object? expiresIn = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_$AccessTokenModelImpl(
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenType: freezed == tokenType
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresIn: freezed == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as int?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AccessTokenModelImpl implements _AccessTokenModel {
  const _$AccessTokenModelImpl(
      {this.accessToken, this.tokenType, this.expiresIn, this.expiresAt});

  factory _$AccessTokenModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccessTokenModelImplFromJson(json);

  @override
  final String? accessToken;
  @override
  final String? tokenType;
  @override
  final int? expiresIn;
  @override
  final DateTime? expiresAt;

  @override
  String toString() {
    return 'AccessTokenModel(accessToken: $accessToken, tokenType: $tokenType, expiresIn: $expiresIn, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccessTokenModelImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.tokenType, tokenType) ||
                other.tokenType == tokenType) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, accessToken, tokenType, expiresIn, expiresAt);

  /// Create a copy of AccessTokenModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccessTokenModelImplCopyWith<_$AccessTokenModelImpl> get copyWith =>
      __$$AccessTokenModelImplCopyWithImpl<_$AccessTokenModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AccessTokenModelImplToJson(
      this,
    );
  }
}

abstract class _AccessTokenModel implements AccessTokenModel {
  const factory _AccessTokenModel(
      {final String? accessToken,
      final String? tokenType,
      final int? expiresIn,
      final DateTime? expiresAt}) = _$AccessTokenModelImpl;

  factory _AccessTokenModel.fromJson(Map<String, dynamic> json) =
      _$AccessTokenModelImpl.fromJson;

  @override
  String? get accessToken;
  @override
  String? get tokenType;
  @override
  int? get expiresIn;
  @override
  DateTime? get expiresAt;

  /// Create a copy of AccessTokenModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccessTokenModelImplCopyWith<_$AccessTokenModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
