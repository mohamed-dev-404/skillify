import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillify/features/sessions/data/models/session_model.dart';
import 'package:skillify/features/sessions/data/repo/sessions_repo.dart';
import 'package:skillify/features/sessions/sessions_tab/view_model/sessions_cubit/sessions_state.dart';

/// SessionsCubit manages the state for fetching and displaying sessions.
///
/// This cubit handles two parallel requests:
/// - getRequestedSessions(): Sessions requested by the current user (He need help so he requested help from other users)
/// - getReceivedSessions(): Sessions received by the current user (He offer help or other users requested help from him)
///
/// The cubit emits a loading state initially, then emits separate success/failure
/// states for each request as they complete.
class SessionsCubit extends Cubit<SessionsState> {
  final SessionsRepo _sessionsRepo;

  /// List of sessions requested by the current user
  List<SessionModel> requestedSessions = [];

  /// List of sessions received by the current user
  List<SessionModel> receivedSessions = [];

  SessionsCubit(this._sessionsRepo) : super(const SessionsLoading());

  /// Fetches both requested and received sessions in parallel using Future.wait().
  ///
  /// This method:
  /// 1. Clears previous data and emits loading state
  /// 2. Makes two API calls in parallel
  /// 3. Emits separate success/failure states for each request as they complete
  Future<void> getSessions() async {
    // Clear previous data at start of request
    requestedSessions = [];
    receivedSessions = [];
    emit(const SessionsLoading());

    // Execute both requests in parallel using Future.wait()
    final results = await Future.wait([
      _sessionsRepo.getRequestedSessions(),
      _sessionsRepo.getReceivedSessions(),
    ]);

    final requestedResult = results[0];
    final receivedResult = results[1];

    // Handle requested sessions result
    requestedResult.fold(
      (errorMessage) {
        emit(RequestedSessionsFailure(errorMessage: errorMessage));
      },
      (sessions) {
        requestedSessions = sessions;
        emit(
          RequestedSessionsSuccess(isEmpty: requestedSessions.isEmpty),
        );
      },
    );

    // Handle received sessions result
    receivedResult.fold(
      (errorMessage) {
        emit(ReceivedSessionsFailure(errorMessage: errorMessage));
      },
      (sessions) {
        receivedSessions = sessions;
        emit(
          ReceivedSessionsSuccess(isEmpty: receivedSessions.isEmpty),
        );
      },
    );
  }
}
