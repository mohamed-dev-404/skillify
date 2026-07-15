import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skillify/features/complete_profile/data/models/complete_profile_request_model.dart';
import 'package:skillify/features/complete_profile/data/models/language_model.dart';
import 'package:skillify/features/complete_profile/data/models/main_skill_model.dart';
import 'package:skillify/features/complete_profile/data/repo/complete_profile_repo.dart';
import 'package:skillify/features/explore/data/models/explore_filters.dart';
import 'package:skillify/features/explore/data/models/explore_user_model.dart';
import 'package:skillify/features/explore/data/models/explore_users_response_model.dart';
import 'package:skillify/features/explore/data/repo/explore_repo.dart';
import 'package:skillify/features/explore/presentation/view_model/explore_cubit/explore_cubit.dart';

void main() {
  test('loads page one then appends and de-duplicates page two', () async {
    final repo = _FakeExploreRepo([
      Right(_response([_user(1), _user(2)], totalCount: 3)),
      Right(_response([_user(2), _user(3)], totalCount: 3)),
    ]);
    final cubit = ExploreCubit(
      exploreRepo: repo,
      completeProfileRepo: _FakeCompleteProfileRepo(),
    );

    await cubit.getUsers();

    expect(repo.requests.first.page, 1);
    expect(repo.requests.first.pageSize, 10);
    expect(cubit.state.usersState.hasMore, isTrue);

    await cubit.loadMoreUsers();

    expect(repo.requests.last.page, 2);
    expect(cubit.state.usersState.users.map((user) => user.userId), [1, 2, 3]);
    expect(cubit.state.usersState.hasMore, isFalse);
    expect(cubit.state.usersState.isLoadingMore, isFalse);

    await cubit.loadMoreUsers();
    expect(repo.requests, hasLength(2));

    await cubit.close();
  });

  test('keeps existing users when loading the next page fails', () async {
    final repo = _FakeExploreRepo([
      Right(_response([_user(1)], totalCount: 2)),
      const Left('Could not load more'),
    ]);
    final cubit = ExploreCubit(
      exploreRepo: repo,
      completeProfileRepo: _FakeCompleteProfileRepo(),
    );

    await cubit.getUsers();
    await cubit.loadMoreUsers();

    expect(cubit.state.usersState.users.map((user) => user.userId), [1]);
    expect(cubit.state.usersState.loadMoreError, 'Could not load more');
    expect(cubit.state.usersState.isLoadingMore, isFalse);

    await cubit.loadMoreUsers();
    expect(repo.requests, hasLength(2));

    await cubit.close();
  });
}

ExploreUserModel _user(int id) {
  return ExploreUserModel(
    userId: id,
    fullName: 'User $id',
    neededMainSkills: const [],
  );
}

ExploreUsersResponseModel _response(
  List<ExploreUserModel> users, {
  required int totalCount,
}) {
  return ExploreUsersResponseModel(items: users, totalCount: totalCount);
}

class _FakeExploreRepo implements ExploreRepo {
  _FakeExploreRepo(this.responses);

  final List<Either<String, ExploreUsersResponseModel>> responses;
  final List<ExploreFilters> requests = [];

  @override
  Future<Either<String, ExploreUsersResponseModel>> getUsers(
    ExploreFilters filters,
  ) async {
    requests.add(filters);
    return responses.removeAt(0);
  }
}

class _FakeCompleteProfileRepo implements CompleteProfileRepo {
  @override
  Future<Either<String, Unit>> completeProfile(
    CompleteProfileRequestModel request,
  ) async {
    return const Right(unit);
  }

  @override
  Future<Either<String, List<LanguageModel>>> getLanguages() async {
    return const Right([]);
  }

  @override
  Future<Either<String, List<MainSkillModel>>>
  getMainSkillsWithSubSkills() async {
    return const Right([]);
  }
}
