part of 'cancel_session_cubit.dart';

sealed class CancelSessionState {}

final class CancelSessionInitial extends CancelSessionState {}

final class CancelSessionLoading extends CancelSessionState {}

final class CancelSessionSuccess extends CancelSessionState {}

final class CancelSessionFailure extends CancelSessionState {
  final String message;
  CancelSessionFailure(this.message);
}
