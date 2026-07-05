import 'package:skillify/core/services/cache/secure_storage/secure_storage_service.dart';
import 'package:skillify/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:skillify/features/auth/data/models/auth_model.dart';
import 'package:skillify/features/auth/data/models/login_request_model.dart';
import 'package:skillify/features/auth/data/models/register_request_model.dart';
import 'package:skillify/features/auth/domain/entities/auth_entity.dart';
import 'package:skillify/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepoImpl(this.remoteDataSource);

  @override
  Future<AuthEntity> login({
    required String email,
    required String password,
  }) async {
    final auth = await remoteDataSource.login(
      LoginRequestModel(email: email, password: password),
    );
    await _cacheTokens(auth);
    return auth;
  }

  @override
  Future<AuthEntity> register({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final auth = await remoteDataSource.register(
      RegisterRequestModel(
        fullName: fullName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      ),
    );
    await _cacheTokens(auth);
    return auth;
  }

  /// Persist the tokens so the interceptors can attach / refresh them.
  Future<void> _cacheTokens(AuthModel auth) async {
    await SecureStorageService.instance.saveAccessToken(auth.accessToken);
    await SecureStorageService.instance.saveRefreshToken(auth.refreshToken);
  }
}
