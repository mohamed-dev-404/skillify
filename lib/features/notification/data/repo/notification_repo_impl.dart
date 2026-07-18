import 'package:dartz/dartz.dart';
import 'package:skillify/core/constants/api_endpoints.dart';
import 'package:skillify/core/constants/api_keys.dart';
import 'package:skillify/core/errors/exceptions/app_exception.dart';
import 'package:skillify/core/services/network/api_consumer.dart';
import 'package:skillify/features/notification/data/models/notification_model.dart';
import 'package:skillify/features/notification/data/repo/notification_repo.dart';

class NotificationRepoImpl implements NotificationRepo {
  final ApiConsumer api;

  const NotificationRepoImpl(this.api);

  @override
  Future<Either<String, List<NotificationModel>>> getNotifications() async {
    try {
      final data = await api.get(EndPoints.getNotifications);

      final notifications = (data as List<dynamic>)
          .map(
            (e) => NotificationModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();

      return Right(notifications);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (_) {
      return const Left('Something went wrong. Please try again');
    }
  }

  @override
  Future<Either<String, int>> getUnreadCount() async {
    try {
      final data = await api.get(EndPoints.unreadNotificationsCount);

      final count =
          ((data as Map<String, dynamic>)[ApiKeys.count] as num?)?.toInt() ?? 0;

      return Right(count);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (_) {
      return const Left('Something went wrong. Please try again');
    }
  }
}
