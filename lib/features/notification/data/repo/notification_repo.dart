import 'package:dartz/dartz.dart';
import 'package:skillify/features/notification/data/models/notification_model.dart';

/// Contract for the notification feature.
///
/// Returns [Either]: Left holds the error message, Right holds the data.
abstract class NotificationRepo {
  Future<Either<String, List<NotificationModel>>> getNotifications();

  Future<Either<String, int>> getUnreadCount();
}
