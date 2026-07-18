part of 'reschedule_session_cubit.dart';

sealed class RescheduleSessionState {}

final class RescheduleSessionInitial extends RescheduleSessionState {}

final class RescheduleSessionLoading extends RescheduleSessionState {}

final class RescheduleSessionSuccess extends RescheduleSessionState {}

final class RescheduleSessionFailure extends RescheduleSessionState {
  final String message;
  RescheduleSessionFailure(this.message);
}
