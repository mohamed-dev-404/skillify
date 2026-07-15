import 'package:dartz/dartz.dart';
import 'package:skillify/features/explore/data/models/explore_filters.dart';
import 'package:skillify/features/explore/data/models/explore_users_response_model.dart';
import 'package:skillify/features/explore/data/models/public_profile/public_profile_model.dart';

abstract class ExploreRepo {
  Future<Either<String, ExploreUsersResponseModel>> getUsers(
    ExploreFilters filters,
  );

  Future<Either<String, PublicProfileModel>> getPublicProfile(int userId);
}
