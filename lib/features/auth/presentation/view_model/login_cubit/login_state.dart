part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final AuthModel auth;

  /// Drives post-login navigation: main (true) or complete profile (false).
  final bool isProfileCompleted;

  LoginSuccess(this.auth, {required this.isProfileCompleted});
}

final class LoginFailure extends LoginState {
  final String message;
  LoginFailure(this.message);
}
