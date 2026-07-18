part of 'notification_cubit.dart';

enum NotificationStatus { initial, loading, success, failure }

class NotificationState {
  const NotificationState({
    this.status = NotificationStatus.initial,
    this.notifications = const [],
    this.unreadCount = 0,
    this.errorMessage,
  });

  final NotificationStatus status;
  final List<NotificationModel> notifications;

  /// Number of unread notifications, used for the header badge.
  /// Sourced from the dedicated `/Notifications/unread-count` endpoint,
  /// or derived from the list after it is fetched.
  final int unreadCount;
  final String? errorMessage;

  NotificationState copyWith({
    NotificationStatus? status,
    List<NotificationModel>? notifications,
    int? unreadCount,
    Object? errorMessage = _unset,
  }) {
    return NotificationState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      unreadCount: unreadCount ?? this.unreadCount,
      errorMessage: identical(errorMessage, _unset)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }
}

const Object _unset = Object();
