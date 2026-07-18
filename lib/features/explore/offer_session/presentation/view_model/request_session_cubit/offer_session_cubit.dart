import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skillify/features/explore/data/models/offer_session/offer_session_request.dart';
import 'package:skillify/features/explore/data/models/offer_session/offer_session_response.dart';
import 'package:skillify/features/explore/data/repo/explore_repo.dart';

part 'offer_session_state.dart';

class OfferSessionCubit extends Cubit<OfferSessionState> {
  OfferSessionCubit(this.exploreRepo) : super(OfferSessionInitial());

  final ExploreRepo exploreRepo;

  Future<void> offerSession(OfferSessionRequest request) async {
    emit(OfferSessionLoading());

    final result = await exploreRepo.offerSession(request);
    result.fold(
      (errorMessage) => emit(OfferSessionFailure(errorMessage)),
      (response) => emit(OfferSessionSuccess(response)),
    );
  }
}
