import 'package:skillify/features/auth/domain/entities/auth_entity.dart';

/// Contract for the auth feature.
///
/// Implementations throw an [AppException] on failure, so callers
/// (use cases / cubits) only need a single try/catch.
abstract class AuthRepo {
  Future<AuthEntity> login({
    required String email,
    required String password,
  });

  Future<AuthEntity> register({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  });
}
