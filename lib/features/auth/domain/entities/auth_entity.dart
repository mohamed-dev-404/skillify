/// Pure domain object that represents an authenticated session.
///
/// It holds the tokens returned by the API after a successful
/// login or register (the register endpoint auto-logs the user in).
class AuthEntity {
  final String accessToken;
  final String refreshToken;
  final int accessTokenExpiresInSeconds;
  final DateTime? accessTokenExpiresAt;
  final DateTime refreshTokenExpiresAt;

  const AuthEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.accessTokenExpiresInSeconds,
    required this.accessTokenExpiresAt,
    required this.refreshTokenExpiresAt,
  });
}
