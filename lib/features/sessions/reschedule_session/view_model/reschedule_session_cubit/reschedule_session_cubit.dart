import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillify/features/sessions/data/models/reschedule_session_request_model.dart';
import 'package:skillify/features/sessions/data/repo/sessions_repo.dart';

part 'reschedule_session_state.dart';

class RescheduleSessionCubit extends Cubit<RescheduleSessionState> {
  final SessionsRepo sessionsRepo;

  RescheduleSessionCubit({required this.sessionsRepo}) : super(RescheduleSessionInitial());

  Future<void> reschedule({
    required int sessionId,
    required RescheduleSessionRequestModel request,
  }) async {
    emit(RescheduleSessionLoading());
    final result = await sessionsRepo.rescheduleSession(
      sessionId: sessionId,
      request: request,
    );
    result.fold(
      (errorMessage) => emit(RescheduleSessionFailure(errorMessage)),
      (_) => emit(RescheduleSessionSuccess()),
    );
  }
}
