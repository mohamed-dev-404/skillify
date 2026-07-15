import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillify/features/explore/data/models/public_profile/public_profile_model.dart';
import 'package:skillify/features/explore/data/repo/explore_repo.dart';

part 'public_profile_state.dart';

class PublicProfileCubit extends Cubit<PublicProfileState> {
  PublicProfileCubit({required this.exploreRepo})
    : super(const PublicProfileState());

  final ExploreRepo exploreRepo;

  Future<void> getPublicProfile(int userId) async {
    if (userId <= 0) {
      emit(
        state.copyWith(
          status: PublicProfileStatus.failure,
          errorMessage: 'Invalid user profile',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: PublicProfileStatus.loading,
        userId: userId,
        errorMessage: null,
      ),
    );

    final result = await exploreRepo.getPublicProfile(userId);
    if (isClosed) return;

    result.fold(
      (errorMessage) => emit(
        state.copyWith(
          status: PublicProfileStatus.failure,
          errorMessage: errorMessage,
        ),
      ),
      (profile) => emit(
        state.copyWith(
          status: PublicProfileStatus.success,
          profile: profile,
          errorMessage: null,
        ),
      ),
    );
  }

  Future<void> refresh() async {
    final userId = state.userId ?? state.profile?.userId;
    if (userId == null) return;

    final result = await exploreRepo.getPublicProfile(userId);
    if (isClosed) return;

    result.fold(
      (errorMessage) => emit(
        state.copyWith(
          status: PublicProfileStatus.failure,
          errorMessage: errorMessage,
        ),
      ),
      (profile) => emit(
        state.copyWith(
          status: PublicProfileStatus.success,
          profile: profile,
          errorMessage: null,
        ),
      ),
    );
  }
}
