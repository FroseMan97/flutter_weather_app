// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CitiesResponseImpl _$$CitiesResponseImplFromJson(Map<String, dynamic> json) =>
    _$CitiesResponseImpl(
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => LocationData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CitiesResponseImplToJson(
        _$CitiesResponseImpl instance) =>
    <String, dynamic>{
      'meta': instance.meta,
      'data': instance.data,
    };

_$MetaImpl _$$MetaImplFromJson(Map<String, dynamic> json) => _$MetaImpl(
      count: (json['count'] as num?)?.toInt(),
      links: json['links'] == null
          ? null
          : MetaLinks.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MetaImplToJson(_$MetaImpl instance) =>
    <String, dynamic>{
      'count': instance.count,
      'links': instance.links,
    };

_$MetaLinksImpl _$$MetaLinksImplFromJson(Map<String, dynamic> json) =>
    _$MetaLinksImpl(
      self: json['self'] as String?,
    );

Map<String, dynamic> _$$MetaLinksImplToJson(_$MetaLinksImpl instance) =>
    <String, dynamic>{
      'self': instance.self,
    };

_$LocationDataImpl _$$LocationDataImplFromJson(Map<String, dynamic> json) =>
    _$LocationDataImpl(
      type: json['type'] as String?,
      subType: json['subType'] as String?,
      name: json['name'] as String?,
      iataCode: json['iataCode'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      geoCode: json['geoCode'] == null
          ? null
          : GeoCode.fromJson(json['geoCode'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LocationDataImplToJson(_$LocationDataImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'subType': instance.subType,
      'name': instance.name,
      'iataCode': instance.iataCode,
      'address': instance.address,
      'geoCode': instance.geoCode,
    };

_$AddressImpl _$$AddressImplFromJson(Map<String, dynamic> json) =>
    _$AddressImpl(
      countryCode: json['countryCode'] as String?,
      stateCode: json['stateCode'] as String?,
    );

Map<String, dynamic> _$$AddressImplToJson(_$AddressImpl instance) =>
    <String, dynamic>{
      'countryCode': instance.countryCode,
      'stateCode': instance.stateCode,
    };

_$GeoCodeImpl _$$GeoCodeImplFromJson(Map<String, dynamic> json) =>
    _$GeoCodeImpl(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$GeoCodeImplToJson(_$GeoCodeImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
