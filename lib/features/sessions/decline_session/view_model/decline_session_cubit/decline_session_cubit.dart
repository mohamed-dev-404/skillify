import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillify/features/sessions/data/repo/sessions_repo.dart';

part 'decline_session_state.dart';

class DeclineSessionCubit extends Cubit<DeclineSessionState> {
  final SessionsRepo sessionsRepo;

  DeclineSessionCubit({required this.sessionsRepo}) : super(DeclineSessionInitial());

  Future<void> decline({required int sessionId}) async {
    emit(DeclineSessionLoading());
    final result = await sessionsRepo.declineSession(sessionId: sessionId);
    result.fold(
      (errorMessage) => emit(DeclineSessionFailure(errorMessage)),
      (_) => emit(DeclineSessionSuccess()),
    );
  }
}
