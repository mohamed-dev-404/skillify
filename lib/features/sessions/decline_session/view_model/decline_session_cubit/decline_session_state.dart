part of 'decline_session_cubit.dart';

sealed class DeclineSessionState {}

final class DeclineSessionInitial extends DeclineSessionState {}

final class DeclineSessionLoading extends DeclineSessionState {}

final class DeclineSessionSuccess extends DeclineSessionState {}

final class DeclineSessionFailure extends DeclineSessionState {
  final String message;
  DeclineSessionFailure(this.message);
}
