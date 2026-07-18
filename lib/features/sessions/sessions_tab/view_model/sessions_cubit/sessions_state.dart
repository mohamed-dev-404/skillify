/// Base class for all SessionsCubit states
sealed class SessionsState {
  const SessionsState();
}

/// Initial state - fetching sessions from both endpoints
class SessionsLoading extends SessionsState {
  const SessionsLoading();
}

/// Requested sessions fetched successfully
class RequestedSessionsSuccess extends SessionsState {
  final bool isEmpty;

  const RequestedSessionsSuccess({required this.isEmpty});
}

/// Failed to fetch requested sessions
class RequestedSessionsFailure extends SessionsState {
  final String errorMessage;

  const RequestedSessionsFailure({required this.errorMessage});
}

/// Received sessions fetched successfully
class ReceivedSessionsSuccess extends SessionsState {
  final bool isEmpty;

  const ReceivedSessionsSuccess({required this.isEmpty});
}

/// Failed to fetch received sessions
class ReceivedSessionsFailure extends SessionsState {
  final String errorMessage;

  const ReceivedSessionsFailure({required this.errorMessage});
}
