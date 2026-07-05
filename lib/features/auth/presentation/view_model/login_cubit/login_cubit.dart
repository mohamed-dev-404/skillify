import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillify/core/errors/exceptions/app_exception.dart';
import 'package:skillify/features/auth/domain/entities/auth_entity.dart';
import 'package:skillify/features/auth/domain/use_cases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit({required this.loginUseCase}) : super(LoginInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      final auth = await loginUseCase(email: email, password: password);
      emit(LoginSuccess(auth));
    } on AppException catch (e) {
      emit(LoginFailure(e.errorModel.errorMessage));
    } catch (_) {
      emit(LoginFailure('Something went wrong. Please try again'));
    }
  }
}
