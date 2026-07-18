import 'package:dartz/dartz.dart';
import 'package:skillify/features/sessions/data/models/reschedule_session_request_model.dart';
import 'package:skillify/features/sessions/data/models/session_model.dart';

/// Contract for the sessions feature.
///
/// Returns [Either]: Left holds the error message, Right holds the data.
abstract class SessionsRepo {
  /// Accept a session by ID
  Future<Either<String, Unit>> acceptSession({required int sessionId});

  /// Decline a session by ID
  Future<Either<String, Unit>> declineSession({required int sessionId});

  /// Cancel a session by ID
  Future<Either<String, Unit>> cancelSession({required int sessionId});

  /// Reschedule a session by ID with new date and optional comment
  Future<Either<String, Unit>> rescheduleSession({
    required int sessionId,
    required RescheduleSessionRequestModel request,
  });

  /// Get all sessions requested by the current user
  Future<Either<String, List<SessionModel>>> getRequestedSessions();

  /// Get all sessions received by the current user
  Future<Either<String, List<SessionModel>>> getReceivedSessions();

  // /// Get a specific session by ID
  // Future<Either<String, SessionModel>> getSessionById({required int sessionId});

  /// Get ZegoCloud token for a session
  Future<Either<String, String>> getZegoToken({required int sessionId});
}
