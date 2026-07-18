import 'package:dartz/dartz.dart';
import 'package:skillify/core/constants/api_endpoints.dart';
import 'package:skillify/core/errors/exceptions/app_exception.dart';
import 'package:skillify/core/services/network/api_consumer.dart';
import 'package:skillify/features/explore/data/models/explore_filters.dart';
import 'package:skillify/features/explore/data/models/explore_users_response_model.dart';
import 'package:skillify/features/explore/data/models/public_profile/public_profile_model.dart';
import 'package:skillify/features/explore/data/models/offer_session/offer_session_request.dart';
import 'package:skillify/features/explore/data/models/offer_session/offer_session_response.dart';
import 'package:skillify/features/explore/data/models/request_session/request_session_request.dart';
import 'package:skillify/features/explore/data/models/request_session/request_session_response.dart';
import 'package:skillify/features/explore/data/repo/explore_repo.dart';

class ExploreRepoImpl implements ExploreRepo {
  const ExploreRepoImpl(this.api);

  final ApiConsumer api;

  @override
  Future<Either<String, ExploreUsersResponseModel>> getUsers(
    ExploreFilters filters,
  ) async {
    try {
      final data = await api.get(
        EndPoints.getUsers,
        queryParameters: filters.toQueryParameters(),
      );

      return Right(
        ExploreUsersResponseModel.fromJson(data as Map<String, dynamic>),
      );
    } on AppException catch (exception) {
      return Left(exception.errorModel.errorMessage);
    } catch (_) {
      return const Left('Something went wrong. Please try again');
    }
  }

  @override
  Future<Either<String, PublicProfileModel>> getPublicProfile(
    int userId,
  ) async {
    try {
      final data = await api.get(EndPoints.getUserById(userId));

      return Right(
        PublicProfileModel.fromJson(data as Map<String, dynamic>),
      );
    } on AppException catch (exception) {
      return Left(exception.errorModel.errorMessage);
    } catch (_) {
      return const Left('Something went wrong. Please try again');
    }
  }

  @override
  Future<Either<String, RequestSessionResponse>> requestSession(
    RequestSessionRequest request,
  ) async {
    try {
      final data = await api.post(
        EndPoints.requestSession,
        data: request.toJson(),
      );

      return Right(
        RequestSessionResponse.fromJson(data as Map<String, dynamic>),
      );
    } on AppException catch (exception) {
      return Left(exception.errorModel.errorMessage);
    } catch (_) {
      return const Left('Something went wrong. Please try again');
    }
  }

  @override
  Future<Either<String, OfferSessionResponse>> offerSession(
    OfferSessionRequest request,
  ) async {
    try {
      final data = await api.post(
        EndPoints.offerSession,
        data: request.toJson(),
      );

      return Right(
        OfferSessionResponse.fromJson(data as Map<String, dynamic>),
      );
    } on AppException catch (exception) {
      return Left(exception.errorModel.errorMessage);
    } catch (_) {
      return const Left('Something went wrong. Please try again');
    }
  }
}
