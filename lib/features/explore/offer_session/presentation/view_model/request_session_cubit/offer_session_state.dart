part of 'offer_session_cubit.dart';

sealed class OfferSessionState extends Equatable {
  const OfferSessionState();

  @override
  List<Object> get props => [];
}

final class OfferSessionInitial extends OfferSessionState {}

final class OfferSessionLoading extends OfferSessionState {}

final class OfferSessionSuccess extends OfferSessionState {
  final OfferSessionResponse response;

  const OfferSessionSuccess(this.response);
}

final class OfferSessionFailure extends OfferSessionState {
  final String? errorMessage;

  const OfferSessionFailure(this.errorMessage);
}
