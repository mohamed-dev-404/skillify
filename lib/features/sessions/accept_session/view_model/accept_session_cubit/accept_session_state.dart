part of 'accept_session_cubit.dart';

sealed class AcceptSessionState {}

final class AcceptSessionInitial extends AcceptSessionState {}

final class AcceptSessionLoading extends AcceptSessionState {}

final class AcceptSessionSuccess extends AcceptSessionState {}

final class AcceptSessionFailure extends AcceptSessionState {
  final String message;
  AcceptSessionFailure(this.message);
}
