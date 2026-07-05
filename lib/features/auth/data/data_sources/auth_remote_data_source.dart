import 'package:skillify/core/constants/api_endpoints.dart';
import 'package:skillify/core/services/network/api_consumer.dart';
import 'package:skillify/features/auth/data/models/auth_model.dart';
import 'package:skillify/features/auth/data/models/login_request_model.dart';
import 'package:skillify/features/auth/data/models/register_request_model.dart';

/// Talks to the auth endpoints. Throws [AppException] (via [ApiConsumer])
/// on any network / server error.
abstract class AuthRemoteDataSource {
  Future<AuthModel> login(LoginRequestModel request);
  Future<AuthModel> register(RegisterRequestModel request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiConsumer api;

  const AuthRemoteDataSourceImpl(this.api);

  @override
  Future<AuthModel> login(LoginRequestModel request) async {
    final data = await api.post(EndPoints.login, data: request.toJson());
    return AuthModel.fromJson(data as Map<String, dynamic>);
  }

  @override
  Future<AuthModel> register(RegisterRequestModel request) async {
    final data = await api.post(EndPoints.register, data: request.toJson());
    return AuthModel.fromJson(data as Map<String, dynamic>);
  }
}
