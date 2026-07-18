import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skillify/features/explore/data/models/request_session/request_session_request.dart';
import 'package:skillify/features/explore/data/models/request_session/request_session_response.dart';
import 'package:skillify/features/explore/data/repo/explore_repo.dart';

part 'request_session_state.dart';

class RequestSessionCubit extends Cubit<RequestSessionState> {
  RequestSessionCubit(this.exploreRepo) : super(RequestSessionInitial());
  final ExploreRepo exploreRepo;
  Future<void> requestSession(RequestSessionRequest request) async {
    emit(RequestSessionLoading());
    final result = await exploreRepo.requestSession(request);
    result.fold(
      (errorMessage) => emit(RequestSessionFailure(errorMessage)),
      (response) => emit(RequestSessionSuccess(response)),
    );
  }
}
