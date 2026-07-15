import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillify/features/complete_profile/data/models/language_model.dart';
import 'package:skillify/features/complete_profile/data/models/main_skill_model.dart';
import 'package:skillify/features/complete_profile/data/repo/complete_profile_repo.dart';
import 'package:skillify/features/explore/data/models/explore_filters.dart';
import 'package:skillify/features/explore/data/models/explore_user_model.dart';
import 'package:skillify/features/explore/data/repo/explore_repo.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit({
    required this.exploreRepo,
    required this.completeProfileRepo,
  }) : super(const ExploreState());

  final ExploreRepo exploreRepo;
  final CompleteProfileRepo completeProfileRepo;
  static const int _pageSize = 10;
  int _requestVersion = 0;

  Future<void> initialize() async {
    await Future.wait([getUsers(), loadLookups()]);
  }

  Future<void> getUsers({ExploreFilters? filters}) async {
    final requestVersion = ++_requestVersion;
    final requestedFilters = filters ?? state.usersState.filters;
    final activeFilters = requestedFilters.copyWith(
      page: 1,
      pageSize: requestedFilters.pageSize ?? _pageSize,
    );

    emit(
      state.copyWith(
        usersState: state.usersState.copyWith(
          status: ExploreUsersStatus.loading,
          filters: activeFilters,
          isLoadingMore: false,
          errorMessage: null,
          loadMoreError: null,
        ),
      ),
    );

    final result = await exploreRepo.getUsers(activeFilters);
    if (isClosed || requestVersion != _requestVersion) return;

    result.fold(
      (errorMessage) => emit(
        state.copyWith(
          usersState: state.usersState.copyWith(
            status: ExploreUsersStatus.failure,
            errorMessage: errorMessage,
          ),
        ),
      ),
      (response) {
        final users = response.items;
        emit(
          state.copyWith(
            usersState: state.usersState.copyWith(
              status: users.isEmpty
                  ? ExploreUsersStatus.empty
                  : ExploreUsersStatus.success,
              users: users,
              totalCount: response.totalCount,
              hasMore: users.length < response.totalCount,
              isLoadingMore: false,
              errorMessage: null,
              loadMoreError: null,
            ),
          ),
        );
      },
    );
  }

  Future<void> loadMoreUsers({bool retry = false}) async {
    final currentUsersState = state.usersState;
    if (currentUsersState.isLoadingMore ||
        !currentUsersState.hasMore ||
        currentUsersState.users.isEmpty ||
        (currentUsersState.loadMoreError != null && !retry)) {
      return;
    }

    final requestVersion = _requestVersion;
    final nextPage = (currentUsersState.filters.page ?? 1) + 1;
    final nextFilters = currentUsersState.filters.copyWith(page: nextPage);

    emit(
      state.copyWith(
        usersState: state.usersState.copyWith(
          isLoadingMore: true,
          loadMoreError: null,
        ),
      ),
    );

    final result = await exploreRepo.getUsers(nextFilters);
    if (isClosed || requestVersion != _requestVersion) return;

    result.fold(
      (errorMessage) => emit(
        state.copyWith(
          usersState: state.usersState.copyWith(
            isLoadingMore: false,
            loadMoreError: errorMessage,
          ),
        ),
      ),
      (response) {
        final usersById = {
          for (final user in state.usersState.users) user.userId: user,
          for (final user in response.items) user.userId: user,
        };
        final users = usersById.values.toList();

        emit(
          state.copyWith(
            usersState: state.usersState.copyWith(
              status: ExploreUsersStatus.success,
              users: users,
              filters: nextFilters,
              totalCount: response.totalCount,
              isLoadingMore: false,
              hasMore: users.length < response.totalCount,
              loadMoreError: null,
            ),
          ),
        );
      },
    );
  }

  Future<Either<String, List<LanguageModel>>> getLanguages() {
    return completeProfileRepo.getLanguages();
  }

  Future<Either<String, List<MainSkillModel>>> getSkills() {
    return completeProfileRepo.getMainSkillsWithSubSkills();
  }

  Future<void> loadLookups() async {
    emit(
      state.copyWith(
        lookupsState: state.lookupsState.copyWith(
          status: ExploreLookupsStatus.loading,
          errorMessage: null,
        ),
      ),
    );

    final languagesFuture = getLanguages();
    final skillsFuture = getSkills();
    final languagesResult = await languagesFuture;
    final skillsResult = await skillsFuture;
    if (isClosed) return;

    String? errorMessage;
    List<LanguageModel> languages = const [];
    List<MainSkillModel> skills = const [];

    languagesResult.fold(
      (error) => errorMessage = error,
      (data) => languages = data,
    );
    skillsResult.fold(
      (error) => errorMessage ??= error,
      (data) => skills = data,
    );

    if (errorMessage != null) {
      emit(
        state.copyWith(
          lookupsState: state.lookupsState.copyWith(
            status: ExploreLookupsStatus.failure,
            errorMessage: errorMessage,
          ),
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        lookupsState: state.lookupsState.copyWith(
          status: ExploreLookupsStatus.success,
          languages: languages,
          skills: skills,
          errorMessage: null,
        ),
      ),
    );
  }

  Future<void> applyFilters(ExploreFilters filters) {
    return getUsers(filters: filters);
  }

  Future<void> clearFilters() {
    return getUsers(filters: const ExploreFilters());
  }
}
