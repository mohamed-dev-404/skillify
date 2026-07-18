import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillify/features/auth/data/repo/auth_repo.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit(this.authRepo) : super(LogoutInitial());
  final AuthRepo authRepo;
  Future<void> logout() async {
    emit(LogoutLoading());
    final result = await authRepo.logout();
    result.fold(
      (errorMessage) => emit(LogoutFailure(errorMessage)),
      (_) => emit(LogoutSuccess()),
    );
  }
}
