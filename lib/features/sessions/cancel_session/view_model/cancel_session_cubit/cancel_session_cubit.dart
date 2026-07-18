import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillify/features/sessions/data/repo/sessions_repo.dart';

part 'cancel_session_state.dart';

class CancelSessionCubit extends Cubit<CancelSessionState> {
  final SessionsRepo sessionsRepo;

  CancelSessionCubit({required this.sessionsRepo}) : super(CancelSessionInitial());

  Future<void> cancel({required int sessionId}) async {
    emit(CancelSessionLoading());
    final result = await sessionsRepo.cancelSession(sessionId: sessionId);
    result.fold(
      (errorMessage) => emit(CancelSessionFailure(errorMessage)),
      (_) => emit(CancelSessionSuccess()),
    );
  }
}
