import 'package:skillify/core/constants/api_keys.dart';

/// Request body for `POST /Users/login`.
class LoginRequestModel {
  final String email;
  final String password;

  const LoginRequestModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    ApiKeys.email: email,
    ApiKeys.password: password,
  };
}
