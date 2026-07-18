import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillify/features/sessions/data/repo/sessions_repo.dart';

part 'accept_session_state.dart';

class AcceptSessionCubit extends Cubit<AcceptSessionState> {
  final SessionsRepo sessionsRepo;

  AcceptSessionCubit({required this.sessionsRepo}) : super(AcceptSessionInitial());

  Future<void> accept({required int sessionId}) async {
    emit(AcceptSessionLoading());
    final result = await sessionsRepo.acceptSession(sessionId: sessionId);
    result.fold(
      (errorMessage) => emit(AcceptSessionFailure(errorMessage)),
      (_) => emit(AcceptSessionSuccess()),
    );
  }
}
