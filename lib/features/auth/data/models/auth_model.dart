import 'package:skillify/core/constants/api_keys.dart';

/// Token payload returned by login / register / refresh
/// (the register endpoint auto-logs the user in).
class AuthModel {
  final String accessToken;
  final String refreshToken;
  final int accessTokenExpiresInSeconds;
  final DateTime? accessTokenExpiresAt;
  final DateTime refreshTokenExpiresAt;

  const AuthModel({
    required this.accessToken,
    required this.refreshToken,
    required this.accessTokenExpiresInSeconds,
    required this.accessTokenExpiresAt,
    required this.refreshTokenExpiresAt,
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
