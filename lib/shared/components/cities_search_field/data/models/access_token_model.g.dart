// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccessTokenModelImpl _$$AccessTokenModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AccessTokenModelImpl(
      accessToken: json['accessToken'] as String?,
      tokenType: json['tokenType'] as String?,
      expiresIn: (json['expiresIn'] as num?)?.toInt(),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$$AccessTokenModelImplToJson(
        _$AccessTokenModelImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'tokenType': instance.tokenType,
      'expiresIn': instance.expiresIn,
      'expiresAt': instance.expiresAt?.toIso8601String(),
    };
