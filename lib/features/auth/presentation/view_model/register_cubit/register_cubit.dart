import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillify/core/errors/exceptions/app_exception.dart';
import 'package:skillify/features/auth/domain/entities/auth_entity.dart';
import 'package:skillify/features/auth/domain/use_cases/register_use_case.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterCubit({required this.registerUseCase}) : super(RegisterInitial());

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(RegisterLoading());
    try {
      final auth = await registerUseCase(
        fullName: fullName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
      emit(RegisterSuccess(auth));
    } on AppException catch (e) {
      emit(RegisterFailure(e.errorModel.errorMessage));
    } catch (_) {
      emit(RegisterFailure('Something went wrong. Please try again'));
    }
  }
}
