import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillify/features/auth/data/models/auth_model.dart';
import 'package:skillify/features/auth/data/repo/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;

  LoginCubit({required this.authRepo}) : super(LoginInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    final result = await authRepo.login(email: email, password: password);
    result.fold(
      (errorMessage) => emit(LoginFailure(errorMessage)),
      (auth) => emit(LoginSuccess(auth)),
    );
  }
}
