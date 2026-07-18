import 'package:dartz/dartz.dart';
import 'package:skillify/core/constants/api_endpoints.dart';
import 'package:skillify/core/constants/api_keys.dart';
import 'package:skillify/core/errors/exceptions/app_exception.dart';
import 'package:skillify/core/services/network/api_consumer.dart';
import 'package:skillify/features/sessions/data/models/reschedule_session_request_model.dart';
import 'package:skillify/features/sessions/data/models/session_model.dart';
import 'package:skillify/features/sessions/data/repo/sessions_repo.dart';

class SessionsRepoImpl implements SessionsRepo {
  final ApiConsumer api;

  const SessionsRepoImpl(this.api);

  @override
  Future<Either<String, Unit>> acceptSession({required int sessionId}) async {
    try {
      await api.post(EndPoints.acceptSession(sessionId));
      return const Right(unit);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (_) {
      return const Left('Something went wrong. Please try again');
    }
  }

  @override
  Future<Either<String, Unit>> declineSession({required int sessionId}) async {
    try {
      await api.post(EndPoints.declineSession(sessionId));
      return const Right(unit);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (_) {
      return const Left('Something went wrong. Please try again');
    }
  }

  @override
  Future<Either<String, Unit>> cancelSession({required int sessionId}) async {
    try {
      await api.post(EndPoints.cancelSession(sessionId));
      return const Right(unit);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (_) {
      return const Left('Something went wrong. Please try again');
    }
  }

  @override
  Future<Either<String, Unit>> rescheduleSession({
    required int sessionId,
    required RescheduleSessionRequestModel request,
  }) async {
    try {
      await api.post(
        EndPoints.rescheduleSession(sessionId),
        data: request.toJson(),
      );
      return const Right(unit);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (_) {
      return const Left('Something went wrong. Please try again');
    }
  }

  @override
  Future<Either<String, List<SessionModel>>> getRequestedSessions() async {
    try {
      final data = await api.get(EndPoints.getRequestedSessions);
      final sessions = (data as List<dynamic>)
          .map((e) => SessionModel.fromJson(e as Map<String, dynamic>, SessionType.requested))
          .toList();
      return Right(sessions);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (_) {
      return const Left('Something went wrong. Please try again');
    }
  }

  @override
  Future<Either<String, List<SessionModel>>> getReceivedSessions() async {
    try {
      final data = await api.get(EndPoints.getReceivedSessions);
      final sessions = (data as List<dynamic>)
          .map((e) => SessionModel.fromJson(e as Map<String, dynamic>, SessionType.received))
          .toList();
      return Right(sessions);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (_) {
      return const Left('Something went wrong. Please try again');
    }
  }

  // @override
  // Future<Either<String, SessionModel>> getSessionById({
  //   required int sessionId,
  // }) async {
  //   try {
  //     final data = await api.get(EndPoints.sessionById(sessionId));
  //     final session = SessionModel.fromJson(data as Map<String, dynamic>);
  //     return Right(session);
  //   } on AppException catch (e) {
  //     return Left(e.errorModel.errorMessage);
  //   } catch (_) {
  //     return const Left('Something went wrong. Please try again');
  //   }
  // }

  @override
  Future<Either<String, String>> getZegoToken({required int sessionId}) async {
    try {
      final data = await api.get(EndPoints.zegoToken(sessionId));
      final token =
          (data as Map<String, dynamic>)[ApiKeys.token] as String? ?? '';
      return Right(token);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (_) {
      return const Left('Something went wrong. Please try again');
    }
  }
}
