// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'city_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CitiesResponse _$CitiesResponseFromJson(Map<String, dynamic> json) {
  return _CitiesResponse.fromJson(json);
}

/// @nodoc
mixin _$CitiesResponse {
  Meta? get meta => throw _privateConstructorUsedError;
  List<LocationData>? get data => throw _privateConstructorUsedError;

  /// Serializes this CitiesResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CitiesResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CitiesResponseCopyWith<CitiesResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CitiesResponseCopyWith<$Res> {
  factory $CitiesResponseCopyWith(
          CitiesResponse value, $Res Function(CitiesResponse) then) =
      _$CitiesResponseCopyWithImpl<$Res, CitiesResponse>;
  @useResult
  $Res call({Meta? meta, List<LocationData>? data});

  $MetaCopyWith<$Res>? get meta;
}

/// @nodoc
class _$CitiesResponseCopyWithImpl<$Res, $Val extends CitiesResponse>
    implements $CitiesResponseCopyWith<$Res> {
  _$CitiesResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CitiesResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meta = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as Meta?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<LocationData>?,
    ) as $Val);
  }

  /// Create a copy of CitiesResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MetaCopyWith<$Res>? get meta {
    if (_value.meta == null) {
      return null;
    }

    return $MetaCopyWith<$Res>(_value.meta!, (value) {
      return _then(_value.copyWith(meta: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CitiesResponseImplCopyWith<$Res>
    implements $CitiesResponseCopyWith<$Res> {
  factory _$$CitiesResponseImplCopyWith(_$CitiesResponseImpl value,
          $Res Function(_$CitiesResponseImpl) then) =
      __$$CitiesResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Meta? meta, List<LocationData>? data});

  @override
  $MetaCopyWith<$Res>? get meta;
}

/// @nodoc
class __$$CitiesResponseImplCopyWithImpl<$Res>
    extends _$CitiesResponseCopyWithImpl<$Res, _$CitiesResponseImpl>
    implements _$$CitiesResponseImplCopyWith<$Res> {
  __$$CitiesResponseImplCopyWithImpl(
      _$CitiesResponseImpl _value, $Res Function(_$CitiesResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of CitiesResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meta = freezed,
    Object? data = freezed,
  }) {
    return _then(_$CitiesResponseImpl(
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as Meta?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<LocationData>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CitiesResponseImpl implements _CitiesResponse {
  const _$CitiesResponseImpl({this.meta, final List<LocationData>? data})
      : _data = data;

  factory _$CitiesResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CitiesResponseImplFromJson(json);

  @override
  final Meta? meta;
  final List<LocationData>? _data;
  @override
  List<LocationData>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CitiesResponse(meta: $meta, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CitiesResponseImpl &&
            (identical(other.meta, meta) || other.meta == meta) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, meta, const DeepCollectionEquality().hash(_data));

  /// Create a copy of CitiesResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CitiesResponseImplCopyWith<_$CitiesResponseImpl> get copyWith =>
      __$$CitiesResponseImplCopyWithImpl<_$CitiesResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CitiesResponseImplToJson(
      this,
    );
  }
}

abstract class _CitiesResponse implements CitiesResponse {
  const factory _CitiesResponse(
      {final Meta? meta,
      final List<LocationData>? data}) = _$CitiesResponseImpl;

  factory _CitiesResponse.fromJson(Map<String, dynamic> json) =
      _$CitiesResponseImpl.fromJson;

  @override
  Meta? get meta;
  @override
  List<LocationData>? get data;

  /// Create a copy of CitiesResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CitiesResponseImplCopyWith<_$CitiesResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Meta _$MetaFromJson(Map<String, dynamic> json) {
  return _Meta.fromJson(json);
}

/// @nodoc
mixin _$Meta {
  int? get count => throw _privateConstructorUsedError;
  MetaLinks? get links => throw _privateConstructorUsedError;

  /// Serializes this Meta to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Meta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MetaCopyWith<Meta> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MetaCopyWith<$Res> {
  factory $MetaCopyWith(Meta value, $Res Function(Meta) then) =
      _$MetaCopyWithImpl<$Res, Meta>;
  @useResult
  $Res call({int? count, MetaLinks? links});

  $MetaLinksCopyWith<$Res>? get links;
}

/// @nodoc
class _$MetaCopyWithImpl<$Res, $Val extends Meta>
    implements $MetaCopyWith<$Res> {
  _$MetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Meta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = freezed,
    Object? links = freezed,
  }) {
    return _then(_value.copyWith(
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      links: freezed == links
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as MetaLinks?,
    ) as $Val);
  }

  /// Create a copy of Meta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MetaLinksCopyWith<$Res>? get links {
    if (_value.links == null) {
      return null;
    }

    return $MetaLinksCopyWith<$Res>(_value.links!, (value) {
      return _then(_value.copyWith(links: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MetaImplCopyWith<$Res> implements $MetaCopyWith<$Res> {
  factory _$$MetaImplCopyWith(
          _$MetaImpl value, $Res Function(_$MetaImpl) then) =
      __$$MetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? count, MetaLinks? links});

  @override
  $MetaLinksCopyWith<$Res>? get links;
}

/// @nodoc
class __$$MetaImplCopyWithImpl<$Res>
    extends _$MetaCopyWithImpl<$Res, _$MetaImpl>
    implements _$$MetaImplCopyWith<$Res> {
  __$$MetaImplCopyWithImpl(_$MetaImpl _value, $Res Function(_$MetaImpl) _then)
      : super(_value, _then);

  /// Create a copy of Meta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = freezed,
    Object? links = freezed,
  }) {
    return _then(_$MetaImpl(
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      links: freezed == links
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as MetaLinks?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MetaImpl implements _Meta {
  const _$MetaImpl({this.count, this.links});

  factory _$MetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$MetaImplFromJson(json);

  @override
  final int? count;
  @override
  final MetaLinks? links;

  @override
  String toString() {
    return 'Meta(count: $count, links: $links)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MetaImpl &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.links, links) || other.links == links));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, count, links);

  /// Create a copy of Meta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MetaImplCopyWith<_$MetaImpl> get copyWith =>
      __$$MetaImplCopyWithImpl<_$MetaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MetaImplToJson(
      this,
    );
  }
}

abstract class _Meta implements Meta {
  const factory _Meta({final int? count, final MetaLinks? links}) = _$MetaImpl;

  factory _Meta.fromJson(Map<String, dynamic> json) = _$MetaImpl.fromJson;

  @override
  int? get count;
  @override
  MetaLinks? get links;

  /// Create a copy of Meta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MetaImplCopyWith<_$MetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MetaLinks _$MetaLinksFromJson(Map<String, dynamic> json) {
  return _MetaLinks.fromJson(json);
}

/// @nodoc
mixin _$MetaLinks {
  String? get self => throw _privateConstructorUsedError;

  /// Serializes this MetaLinks to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MetaLinks
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MetaLinksCopyWith<MetaLinks> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MetaLinksCopyWith<$Res> {
  factory $MetaLinksCopyWith(MetaLinks value, $Res Function(MetaLinks) then) =
      _$MetaLinksCopyWithImpl<$Res, MetaLinks>;
  @useResult
  $Res call({String? self});
}

/// @nodoc
class _$MetaLinksCopyWithImpl<$Res, $Val extends MetaLinks>
    implements $MetaLinksCopyWith<$Res> {
  _$MetaLinksCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MetaLinks
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? self = freezed,
  }) {
    return _then(_value.copyWith(
      self: freezed == self
          ? _value.self
          : self // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MetaLinksImplCopyWith<$Res>
    implements $MetaLinksCopyWith<$Res> {
  factory _$$MetaLinksImplCopyWith(
          _$MetaLinksImpl value, $Res Function(_$MetaLinksImpl) then) =
      __$$MetaLinksImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? self});
}

/// @nodoc
class __$$MetaLinksImplCopyWithImpl<$Res>
    extends _$MetaLinksCopyWithImpl<$Res, _$MetaLinksImpl>
    implements _$$MetaLinksImplCopyWith<$Res> {
  __$$MetaLinksImplCopyWithImpl(
      _$MetaLinksImpl _value, $Res Function(_$MetaLinksImpl) _then)
      : super(_value, _then);

  /// Create a copy of MetaLinks
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? self = freezed,
  }) {
    return _then(_$MetaLinksImpl(
      self: freezed == self
          ? _value.self
          : self // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MetaLinksImpl implements _MetaLinks {
  const _$MetaLinksImpl({this.self});

  factory _$MetaLinksImpl.fromJson(Map<String, dynamic> json) =>
      _$$MetaLinksImplFromJson(json);

  @override
  final String? self;

  @override
  String toString() {
    return 'MetaLinks(self: $self)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MetaLinksImpl &&
            (identical(other.self, self) || other.self == self));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, self);

  /// Create a copy of MetaLinks
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MetaLinksImplCopyWith<_$MetaLinksImpl> get copyWith =>
      __$$MetaLinksImplCopyWithImpl<_$MetaLinksImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MetaLinksImplToJson(
      this,
    );
  }
}

abstract class _MetaLinks implements MetaLinks {
  const factory _MetaLinks({final String? self}) = _$MetaLinksImpl;

  factory _MetaLinks.fromJson(Map<String, dynamic> json) =
      _$MetaLinksImpl.fromJson;

  @override
  String? get self;

  /// Create a copy of MetaLinks
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MetaLinksImplCopyWith<_$MetaLinksImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LocationData _$LocationDataFromJson(Map<String, dynamic> json) {
  return _LocationData.fromJson(json);
}

/// @nodoc
mixin _$LocationData {
  String? get type => throw _privateConstructorUsedError;
  String? get subType => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get iataCode => throw _privateConstructorUsedError;
  Address? get address => throw _privateConstructorUsedError;
  GeoCode? get geoCode => throw _privateConstructorUsedError;

  /// Serializes this LocationData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationDataCopyWith<LocationData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationDataCopyWith<$Res> {
  factory $LocationDataCopyWith(
          LocationData value, $Res Function(LocationData) then) =
      _$LocationDataCopyWithImpl<$Res, LocationData>;
  @useResult
  $Res call(
      {String? type,
      String? subType,
      String? name,
      String? iataCode,
      Address? address,
      GeoCode? geoCode});

  $AddressCopyWith<$Res>? get address;
  $GeoCodeCopyWith<$Res>? get geoCode;
}

/// @nodoc
class _$LocationDataCopyWithImpl<$Res, $Val extends LocationData>
    implements $LocationDataCopyWith<$Res> {
  _$LocationDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? subType = freezed,
    Object? name = freezed,
    Object? iataCode = freezed,
    Object? address = freezed,
    Object? geoCode = freezed,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      subType: freezed == subType
          ? _value.subType
          : subType // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      iataCode: freezed == iataCode
          ? _value.iataCode
          : iataCode // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      geoCode: freezed == geoCode
          ? _value.geoCode
          : geoCode // ignore: cast_nullable_to_non_nullable
              as GeoCode?,
    ) as $Val);
  }

  /// Create a copy of LocationData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }

  /// Create a copy of LocationData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GeoCodeCopyWith<$Res>? get geoCode {
    if (_value.geoCode == null) {
      return null;
    }

    return $GeoCodeCopyWith<$Res>(_value.geoCode!, (value) {
      return _then(_value.copyWith(geoCode: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LocationDataImplCopyWith<$Res>
    implements $LocationDataCopyWith<$Res> {
  factory _$$LocationDataImplCopyWith(
          _$LocationDataImpl value, $Res Function(_$LocationDataImpl) then) =
      __$$LocationDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? type,
      String? subType,
      String? name,
      String? iataCode,
      Address? address,
      GeoCode? geoCode});

  @override
  $AddressCopyWith<$Res>? get address;
  @override
  $GeoCodeCopyWith<$Res>? get geoCode;
}

/// @nodoc
class __$$LocationDataImplCopyWithImpl<$Res>
    extends _$LocationDataCopyWithImpl<$Res, _$LocationDataImpl>
    implements _$$LocationDataImplCopyWith<$Res> {
  __$$LocationDataImplCopyWithImpl(
      _$LocationDataImpl _value, $Res Function(_$LocationDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? subType = freezed,
    Object? name = freezed,
    Object? iataCode = freezed,
    Object? address = freezed,
    Object? geoCode = freezed,
  }) {
    return _then(_$LocationDataImpl(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      subType: freezed == subType
          ? _value.subType
          : subType // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      iataCode: freezed == iataCode
          ? _value.iataCode
          : iataCode // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      geoCode: freezed == geoCode
          ? _value.geoCode
          : geoCode // ignore: cast_nullable_to_non_nullable
              as GeoCode?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationDataImpl implements _LocationData {
  const _$LocationDataImpl(
      {this.type,
      this.subType,
      this.name,
      this.iataCode,
      this.address,
      this.geoCode});

  factory _$LocationDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationDataImplFromJson(json);

  @override
  final String? type;
  @override
  final String? subType;
  @override
  final String? name;
  @override
  final String? iataCode;
  @override
  final Address? address;
  @override
  final GeoCode? geoCode;

  @override
  String toString() {
    return 'LocationData(type: $type, subType: $subType, name: $name, iataCode: $iataCode, address: $address, geoCode: $geoCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationDataImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.subType, subType) || other.subType == subType) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.iataCode, iataCode) ||
                other.iataCode == iataCode) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.geoCode, geoCode) || other.geoCode == geoCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, subType, name, iataCode, address, geoCode);

  /// Create a copy of LocationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationDataImplCopyWith<_$LocationDataImpl> get copyWith =>
      __$$LocationDataImplCopyWithImpl<_$LocationDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationDataImplToJson(
      this,
    );
  }
}

abstract class _LocationData implements LocationData {
  const factory _LocationData(
      {final String? type,
      final String? subType,
      final String? name,
      final String? iataCode,
      final Address? address,
      final GeoCode? geoCode}) = _$LocationDataImpl;

  factory _LocationData.fromJson(Map<String, dynamic> json) =
      _$LocationDataImpl.fromJson;

  @override
  String? get type;
  @override
  String? get subType;
  @override
  String? get name;
  @override
  String? get iataCode;
  @override
  Address? get address;
  @override
  GeoCode? get geoCode;

  /// Create a copy of LocationData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationDataImplCopyWith<_$LocationDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Address _$AddressFromJson(Map<String, dynamic> json) {
  return _Address.fromJson(json);
}

/// @nodoc
mixin _$Address {
  String? get countryCode => throw _privateConstructorUsedError;
  String? get stateCode => throw _privateConstructorUsedError;

  /// Serializes this Address to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressCopyWith<Address> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressCopyWith<$Res> {
  factory $AddressCopyWith(Address value, $Res Function(Address) then) =
      _$AddressCopyWithImpl<$Res, Address>;
  @useResult
  $Res call({String? countryCode, String? stateCode});
}

/// @nodoc
class _$AddressCopyWithImpl<$Res, $Val extends Address>
    implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? countryCode = freezed,
    Object? stateCode = freezed,
  }) {
    return _then(_value.copyWith(
      countryCode: freezed == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      stateCode: freezed == stateCode
          ? _value.stateCode
          : stateCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddressImplCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$$AddressImplCopyWith(
          _$AddressImpl value, $Res Function(_$AddressImpl) then) =
      __$$AddressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? countryCode, String? stateCode});
}

/// @nodoc
class __$$AddressImplCopyWithImpl<$Res>
    extends _$AddressCopyWithImpl<$Res, _$AddressImpl>
    implements _$$AddressImplCopyWith<$Res> {
  __$$AddressImplCopyWithImpl(
      _$AddressImpl _value, $Res Function(_$AddressImpl) _then)
      : super(_value, _then);

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? countryCode = freezed,
    Object? stateCode = freezed,
  }) {
    return _then(_$AddressImpl(
      countryCode: freezed == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      stateCode: freezed == stateCode
          ? _value.stateCode
          : stateCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressImpl implements _Address {
  const _$AddressImpl({this.countryCode, this.stateCode});

  factory _$AddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressImplFromJson(json);

  @override
  final String? countryCode;
  @override
  final String? stateCode;

  @override
  String toString() {
    return 'Address(countryCode: $countryCode, stateCode: $stateCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressImpl &&
            (identical(other.countryCode, countryCode) ||
                other.countryCode == countryCode) &&
            (identical(other.stateCode, stateCode) ||
                other.stateCode == stateCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, countryCode, stateCode);

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      __$$AddressImplCopyWithImpl<_$AddressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressImplToJson(
      this,
    );
  }
}

abstract class _Address implements Address {
  const factory _Address({final String? countryCode, final String? stateCode}) =
      _$AddressImpl;

  factory _Address.fromJson(Map<String, dynamic> json) = _$AddressImpl.fromJson;

  @override
  String? get countryCode;
  @override
  String? get stateCode;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GeoCode _$GeoCodeFromJson(Map<String, dynamic> json) {
  return _GeoCode.fromJson(json);
}

/// @nodoc
mixin _$GeoCode {
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;

  /// Serializes this GeoCode to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GeoCode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GeoCodeCopyWith<GeoCode> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeoCodeCopyWith<$Res> {
  factory $GeoCodeCopyWith(GeoCode value, $Res Function(GeoCode) then) =
      _$GeoCodeCopyWithImpl<$Res, GeoCode>;
  @useResult
  $Res call({double? latitude, double? longitude});
}

/// @nodoc
class _$GeoCodeCopyWithImpl<$Res, $Val extends GeoCode>
    implements $GeoCodeCopyWith<$Res> {
  _$GeoCodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GeoCode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(_value.copyWith(
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GeoCodeImplCopyWith<$Res> implements $GeoCodeCopyWith<$Res> {
  factory _$$GeoCodeImplCopyWith(
          _$GeoCodeImpl value, $Res Function(_$GeoCodeImpl) then) =
      __$$GeoCodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double? latitude, double? longitude});
}

/// @nodoc
class __$$GeoCodeImplCopyWithImpl<$Res>
    extends _$GeoCodeCopyWithImpl<$Res, _$GeoCodeImpl>
    implements _$$GeoCodeImplCopyWith<$Res> {
  __$$GeoCodeImplCopyWithImpl(
      _$GeoCodeImpl _value, $Res Function(_$GeoCodeImpl) _then)
      : super(_value, _then);

  /// Create a copy of GeoCode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(_$GeoCodeImpl(
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GeoCodeImpl implements _GeoCode {
  const _$GeoCodeImpl({this.latitude, this.longitude});

  factory _$GeoCodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeoCodeImplFromJson(json);

  @override
  final double? latitude;
  @override
  final double? longitude;

  @override
  String toString() {
    return 'GeoCode(latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeoCodeImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, latitude, longitude);

  /// Create a copy of GeoCode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GeoCodeImplCopyWith<_$GeoCodeImpl> get copyWith =>
      __$$GeoCodeImplCopyWithImpl<_$GeoCodeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GeoCodeImplToJson(
      this,
    );
  }
}

abstract class _GeoCode implements GeoCode {
  const factory _GeoCode({final double? latitude, final double? longitude}) =
      _$GeoCodeImpl;

  factory _GeoCode.fromJson(Map<String, dynamic> json) = _$GeoCodeImpl.fromJson;

  @override
  double? get latitude;
  @override
  double? get longitude;

  /// Create a copy of GeoCode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GeoCodeImplCopyWith<_$GeoCodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
