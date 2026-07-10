import 'package:dartz/dartz.dart';
import 'package:skillify/features/auth/data/models/auth_model.dart';

/// Contract for the auth feature.
///
/// Returns [Either]: Left holds the error message, Right holds the data.
abstract class AuthRepo {
  Future<Either<String, AuthModel>> login({
    required String email,
    required String password,
  });

  Future<Either<String, AuthModel>> register({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  });

  /// Whether the logged-in user has completed their profile
  /// (checked from `GET /Users/me`: offeredSkill is set).
  Future<Either<String, bool>> isProfileCompleted();
}
