import 'package:equatable/equatable.dart';
import 'package:skillify/core/constants/api_keys.dart';

class AuthModel extends Equatable {
  final String accessToken;
  final String refreshToken;
  final int accessTokenExpiresInSeconds;
  final DateTime accessTokenExpiresAt;
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
          json[ApiKeys.accessTokenExpiresInSeconds] as int,
      accessTokenExpiresAt: DateTime.parse(
        json[ApiKeys.accessTokenExpiresAt] as String,
      ),
      refreshTokenExpiresAt: DateTime.parse(
        json[ApiKeys.refreshTokenExpiresAt] as String,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.accessToken: accessToken,
      ApiKeys.refreshToken: refreshToken,
      ApiKeys.accessTokenExpiresInSeconds: accessTokenExpiresInSeconds,
      ApiKeys.accessTokenExpiresAt: accessTokenExpiresAt.toIso8601String(),
      ApiKeys.refreshTokenExpiresAt: refreshTokenExpiresAt.toIso8601String(),
    };
  }

  @override
  List<Object> get props => [
    accessToken,
    refreshToken,
    accessTokenExpiresInSeconds,
    accessTokenExpiresAt,
    refreshTokenExpiresAt,
  ];
}
