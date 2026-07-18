part of 'request_session_cubit.dart';

sealed class RequestSessionState extends Equatable {
  const RequestSessionState();

  @override
  List<Object> get props => [];
}

final class RequestSessionInitial extends RequestSessionState {}

final class RequestSessionLoading extends RequestSessionState {}

final class RequestSessionSuccess extends RequestSessionState {
  final RequestSessionResponse response;

  const RequestSessionSuccess(this.response);
}

final class RequestSessionFailure extends RequestSessionState {
  final String? errorMessage;

  const RequestSessionFailure(this.errorMessage);
}
