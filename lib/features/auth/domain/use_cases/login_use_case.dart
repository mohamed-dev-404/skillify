import 'package:skillify/features/auth/domain/entities/auth_entity.dart';
import 'package:skillify/features/auth/domain/repo/auth_repo.dart';

/// Logs a user in with email & password.
class LoginUseCase {
  final AuthRepo authRepo;

  const LoginUseCase(this.authRepo);

  Future<AuthEntity> call({
    required String email,
    required String password,
  }) {
    return authRepo.login(email: email, password: password);
  }
}
