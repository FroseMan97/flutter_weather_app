import 'package:freezed_annotation/freezed_annotation.dart';

part 'access_token_model.freezed.dart';
part 'access_token_model.g.dart';

@freezed
class AccessTokenModel with _$AccessTokenModel {
  const factory AccessTokenModel({
    String? accessToken,
    String? tokenType,
    int? expiresIn,
    DateTime? expiresAt,
  }) = _AccessTokenModel;

  factory AccessTokenModel.fromJson(Map<String, dynamic> json) => _$AccessTokenModelFromJson(json);
}

extension AccessTokenModelExtension on AccessTokenModel {
  bool get isExpired => expiresAt != null && DateTime.now().isAfter(expiresAt!);
}

