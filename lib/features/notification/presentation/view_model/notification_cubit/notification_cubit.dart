import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillify/features/notification/data/models/notification_model.dart';
import 'package:skillify/features/notification/data/repo/notification_repo.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit({required this.notificationRepo})
    : super(const NotificationState());

  final NotificationRepo notificationRepo;

  Future<void> fetchNotifications() async {
    emit(
      state.copyWith(
        status: NotificationStatus.loading,
        errorMessage: null,
      ),
    );

    final result = await notificationRepo.getNotifications();
    if (isClosed) return;

    result.fold(
      (errorMessage) => emit(
        state.copyWith(
          status: NotificationStatus.failure,
          errorMessage: errorMessage,
        ),
      ),
      (notifications) => emit(
        state.copyWith(
          status: NotificationStatus.success,
          notifications: notifications,
          unreadCount: notifications
              .where((notification) => !notification.isRead)
              .length,
          errorMessage: null,
        ),
      ),
    );
  }

  /// Fetches only the unread count (cheap call used for the header badge).
  /// Failures are ignored silently so the badge simply stays hidden.
  Future<void> fetchUnreadCount() async {
    final result = await notificationRepo.getUnreadCount();
    if (isClosed) return;

    result.fold(
      (_) {},
      (count) => emit(state.copyWith(unreadCount: count)),
    );
  }
}
