import 'package:skillify/core/constants/api_keys.dart';

/// A single notification returned by GET /Notifications.
class NotificationModel {
  final int id;
  final String title;
  final String message;
  final bool isRead;
  final DateTime? createdAt;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: (json[ApiKeys.id] as num?)?.toInt() ?? 0,
      title: json[ApiKeys.title] as String? ?? '',
      message: json[ApiKeys.message] as String? ?? '',
      isRead: json[ApiKeys.isRead] as bool? ?? false,
      createdAt: json[ApiKeys.createdAt] != null
          ? DateTime.tryParse(json[ApiKeys.createdAt] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    ApiKeys.id: id,
    ApiKeys.title: title,
    ApiKeys.message: message,
    ApiKeys.isRead: isRead,
    ApiKeys.createdAt: createdAt?.toIso8601String(),
  };
}
