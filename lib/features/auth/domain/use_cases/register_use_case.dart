import 'package:skillify/features/auth/domain/entities/auth_entity.dart';
import 'package:skillify/features/auth/domain/repo/auth_repo.dart';

/// Registers a new user. The API auto-logs the user in and returns tokens.
class RegisterUseCase {
  final AuthRepo authRepo;

  const RegisterUseCase(this.authRepo);

  Future<AuthEntity> call({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    return authRepo.register(
      fullName: fullName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
