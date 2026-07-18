import 'package:dartz/dartz.dart';
import 'package:skillify/features/explore/data/models/explore_filters.dart';
import 'package:skillify/features/explore/data/models/explore_users_response_model.dart';
import 'package:skillify/features/explore/data/models/public_profile/public_profile_model.dart';
import 'package:skillify/features/explore/data/models/offer_session/offer_session_request.dart';
import 'package:skillify/features/explore/data/models/offer_session/offer_session_response.dart';
import 'package:skillify/features/explore/data/models/request_session/request_session_request.dart';
import 'package:skillify/features/explore/data/models/request_session/request_session_response.dart';

abstract class ExploreRepo {
  Future<Either<String, ExploreUsersResponseModel>> getUsers(
    ExploreFilters filters,
  );

  Future<Either<String, PublicProfileModel>> getPublicProfile(int userId);
  Future<Either<String, RequestSessionResponse>> requestSession(
    RequestSessionRequest request,
  );
  Future<Either<String, OfferSessionResponse>> offerSession(
    OfferSessionRequest request,
  );
}
