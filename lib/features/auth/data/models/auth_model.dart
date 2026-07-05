import 'package:skillify/core/constants/api_keys.dart';
import 'package:skillify/features/auth/domain/entities/auth_entity.dart';

/// Data model for the token payload returned by login / register / refresh.
class AuthModel extends AuthEntity {
  const AuthModel({
    required super.accessToken,
    required super.refreshToken,
    required super.accessTokenExpiresInSeconds,
    required super.accessTokenExpiresAt,
    required super.refreshTokenExpiresAt,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json[ApiKeys.accessToken] as String,
      refreshToken: json[ApiKeys.refreshToken] as String,
      accessTokenExpiresInSeconds:
          (json[ApiKeys.accessTokenExpiresInSeconds] as num).toInt(),
      accessTokenExpiresAt: json[ApiKeys.accessTokenExpiresAt] != null
          ? DateTime.parse(json[ApiKeys.accessTokenExpiresAt] as String)
          : null,
      refreshTokenExpiresAt: DateTime.parse(
        json[ApiKeys.refreshTokenExpiresAt] as String,
      ),
    );
  }
}
