// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CityResponseImpl _$$CityResponseImplFromJson(Map<String, dynamic> json) =>
    _$CityResponseImpl(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CityData.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CityResponseImplToJson(_$CityResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };

_$CityDataImpl _$$CityDataImplFromJson(Map<String, dynamic> json) =>
    _$CityDataImpl(
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

Map<String, dynamic> _$$CityDataImplToJson(_$CityDataImpl instance) =>
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

_$MetaImpl _$$MetaImplFromJson(Map<String, dynamic> json) => _$MetaImpl(
      count: (json['count'] as num?)?.toInt(),
      links: json['links'] == null
          ? null
          : Links.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MetaImplToJson(_$MetaImpl instance) =>
    <String, dynamic>{
      'count': instance.count,
      'links': instance.links,
    };

_$LinksImpl _$$LinksImplFromJson(Map<String, dynamic> json) => _$LinksImpl(
      self: json['self'] as String?,
    );

Map<String, dynamic> _$$LinksImplToJson(_$LinksImpl instance) =>
    <String, dynamic>{
      'self': instance.self,
    };
