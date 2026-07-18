import 'package:dartz/dartz.dart';
import 'package:skillify/core/constants/api_endpoints.dart';
import 'package:skillify/core/errors/exceptions/app_exception.dart';
import 'package:skillify/core/services/cache/secure_storage/secure_storage_service.dart';
import 'package:skillify/core/services/network/api_consumer.dart';
import 'package:skillify/features/auth/data/models/auth_model.dart';
import 'package:skillify/features/auth/data/models/login_request_model.dart';
import 'package:skillify/features/auth/data/models/register_request_model.dart';
import 'package:skillify/features/auth/data/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiConsumer api;

  const AuthRepoImpl(this.api);

  @override
  Future<Either<String, AuthModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final data = await api.post(
        EndPoints.login,
        data: LoginRequestModel(email: email, password: password).toJson(),
      );
      final auth = AuthModel.fromJson(data as Map<String, dynamic>);
      await _cacheTokens(auth);
      return Right(auth);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (_) {
      return const Left('Something went wrong. Please try again');
    }
  }

  @override
  Future<Either<String, AuthModel>> register({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final data = await api.post(
        EndPoints.register,
        data: RegisterRequestModel(
          fullName: fullName,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
        ).toJson(),
      );
      final auth = AuthModel.fromJson(data as Map<String, dynamic>);
      await _cacheTokens(auth);
      return Right(auth);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (_) {
      return const Left('Something went wrong. Please try again');
    }
  }

  @override
  Future<Either<String, Unit>> logout() async {
    try {
      await api.post(EndPoints.logout);
      return const Right(unit);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (_) {
      return const Left('Something went wrong. Please try again');
    }
  }

  /// Persist the tokens so the interceptors can attach / refresh them.
  Future<void> _cacheTokens(AuthModel auth) async {
    await SecureStorageService.instance.saveAccessToken(auth.accessToken);
    await SecureStorageService.instance.saveRefreshToken(auth.refreshToken);
  }
}
