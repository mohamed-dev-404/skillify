import 'package:skillify/core/constants/api_keys.dart';

/// Request body for `POST /Users/register`.
class RegisterRequestModel {
  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;

  const RegisterRequestModel({
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
    ApiKeys.fullName: fullName,
    ApiKeys.email: email,
    ApiKeys.password: password,
    ApiKeys.confirmPassword: confirmPassword,
  };
}
