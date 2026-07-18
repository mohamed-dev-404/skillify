part of 'explore_cubit.dart';

enum ExploreUsersStatus { initial, loading, success, empty, failure }

enum ExploreLookupsStatus { initial, loading, success, failure }

@immutable
class ExploreState {
  const ExploreState({
    this.usersState = const ExploreUsersState(),
    this.lookupsState = const ExploreLookupsState(),
  });

  final ExploreUsersState usersState;
  final ExploreLookupsState lookupsState;

  ExploreState copyWith({
    ExploreUsersState? usersState,
    ExploreLookupsState? lookupsState,
  }) {
    return ExploreState(
      usersState: usersState ?? this.usersState,
      lookupsState: lookupsState ?? this.lookupsState,
    );
  }
}

@immutable
class ExploreUsersState {
  const ExploreUsersState({
    this.status = ExploreUsersStatus.initial,
    this.users = const [],
    this.filters = const ExploreFilters(),
    this.totalCount = 0,
    this.isLoadingMore = false,
    this.hasMore = false,
    this.errorMessage,
    this.loadMoreError,
  });

  final ExploreUsersStatus status;
  final List<ExploreUserModel> users;
  final ExploreFilters filters;
  final int totalCount;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorMessage;
  final String? loadMoreError;

  ExploreUsersState copyWith({
    ExploreUsersStatus? status,
    List<ExploreUserModel>? users,
    ExploreFilters? filters,
    int? totalCount,
    bool? isLoadingMore,
    bool? hasMore,
    Object? errorMessage = _unset,
    Object? loadMoreError = _unset,
  }) {
    return ExploreUsersState(
      status: status ?? this.status,
      users: users ?? this.users,
      filters: filters ?? this.filters,
      totalCount: totalCount ?? this.totalCount,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: identical(errorMessage, _unset)
          ? this.errorMessage
          : errorMessage as String?,
      loadMoreError: identical(loadMoreError, _unset)
          ? this.loadMoreError
          : loadMoreError as String?,
    );
  }
}

@immutable
class ExploreLookupsState {
  const ExploreLookupsState({
    this.status = ExploreLookupsStatus.initial,
    this.languages = const [],
    this.skills = const [],
    this.errorMessage,
  });

  final ExploreLookupsStatus status;
  final List<LanguageModel> languages;
  final List<MainSkillModel> skills;
  final String? errorMessage;

  ExploreLookupsState copyWith({
    ExploreLookupsStatus? status,
    List<LanguageModel>? languages,
    List<MainSkillModel>? skills,
    Object? errorMessage = _unset,
  }) {
    return ExploreLookupsState(
      status: status ?? this.status,
      languages: languages ?? this.languages,
      skills: skills ?? this.skills,
      errorMessage: identical(errorMessage, _unset)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }
}

const Object _unset = Object();
