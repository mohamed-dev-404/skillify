import 'package:skillify/core/constants/api_keys.dart';

enum SessionStatus {
  pending,
  accepted,
  declined,
  reOffered,
  active,
  completed,
  cancelled,
  expired,
}

enum SessionType {
  requested,
  received,
}

class SessionModel {
  final int id;
  final int requesterId;
  final String requesterName;
  final int helperId;
  final String helperName;
  final int mainSkillId;
  final String mainSkillName;
  final String topic;
  final String problemDescription;
  final int durationMinutes;
  final int creditCost;
  final int status;
  final DateTime? scheduledAt;
  final DateTime? acceptedAt;
  final DateTime? completedAt;
  final DateTime createdAt;
  final String? zegoRoomId;
  final bool userRated;
  final bool userCanRate;
  final num userRatingScore;
  final SessionType sessionType;
  final bool pendingRescheduleByUser;

  const SessionModel({
    required this.id,
    required this.requesterId,
    required this.requesterName,
    required this.helperId,
    required this.helperName,
    required this.mainSkillId,
    required this.mainSkillName,
    required this.topic,
    required this.problemDescription,
    required this.durationMinutes,
    required this.creditCost,
    required this.status,
    required this.scheduledAt,
    required this.acceptedAt,
    required this.completedAt,
    required this.createdAt,
    required this.userRated,
    required this.userCanRate,
    required this.userRatingScore,
    required this.sessionType,
    required this.pendingRescheduleByUser,
    this.zegoRoomId,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json, SessionType type) {
    return SessionModel(
      id: (json[ApiKeys.id] as num).toInt(),
      requesterId: (json[ApiKeys.requesterId] as num).toInt(),
      requesterName: json[ApiKeys.requesterName] as String? ?? '',
      helperId: (json[ApiKeys.helperId] as num).toInt(),
      helperName: json[ApiKeys.helperName] as String? ?? '',
      mainSkillId: (json[ApiKeys.mainSkillId] as num).toInt(),
      mainSkillName: json[ApiKeys.mainSkillName] as String? ?? '',
      topic: json[ApiKeys.topic] as String? ?? '',
      problemDescription: json[ApiKeys.problemDescription] as String? ?? '',
      durationMinutes: (json[ApiKeys.durationMinutes] as num).toInt(),
      creditCost: (json[ApiKeys.creditCost] as num).toInt(),
      status: (json[ApiKeys.status] as num).toInt(),
      scheduledAt: json[ApiKeys.scheduledAt] != null
          ? DateTime.parse(json[ApiKeys.scheduledAt] as String)
          : null,
      acceptedAt: json[ApiKeys.acceptedAt] != null
          ? DateTime.parse(json[ApiKeys.acceptedAt] as String)
          : null,
      completedAt: json[ApiKeys.completedAt] != null
          ? DateTime.parse(json[ApiKeys.completedAt] as String)
          : null,
      createdAt: DateTime.parse(json[ApiKeys.createdAt] as String),
      zegoRoomId: json[ApiKeys.zegoRoomId] as String?,
      userRated: json[ApiKeys.userRated] as bool? ?? false,
      userCanRate: json[ApiKeys.userCanRate] as bool? ?? false,
      userRatingScore: json[ApiKeys.userRatingScore] as num? ?? 0,
      sessionType: type,
      pendingRescheduleByUser: json[ApiKeys.pendingRescheduleByUser] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.id: id,
      ApiKeys.requesterId: requesterId,
      ApiKeys.requesterName: requesterName,
      ApiKeys.helperId: helperId,
      ApiKeys.helperName: helperName,
      ApiKeys.mainSkillId: mainSkillId,
      ApiKeys.mainSkillName: mainSkillName,
      ApiKeys.topic: topic,
      ApiKeys.problemDescription: problemDescription,
      ApiKeys.durationMinutes: durationMinutes,
      ApiKeys.creditCost: creditCost,
      ApiKeys.status: status,
      ApiKeys.scheduledAt: scheduledAt?.toIso8601String(),
      ApiKeys.acceptedAt: acceptedAt?.toIso8601String(),
      ApiKeys.completedAt: completedAt?.toIso8601String(),
      ApiKeys.createdAt: createdAt.toIso8601String(),
      ApiKeys.zegoRoomId: zegoRoomId,
      ApiKeys.userRated: userRated,
      ApiKeys.userCanRate: userCanRate,
      ApiKeys.userRatingScore: userRatingScore,
      ApiKeys.pendingRescheduleByUser: pendingRescheduleByUser,
    };
  }

  SessionStatus get sessionStatus {
    if (status < 0 || status >= SessionStatus.values.length) {
      return SessionStatus
          .expired; // Default to expired if the status is out of range
    }
    return SessionStatus.values[status];
  }

  bool get isRequested => sessionType == SessionType.requested;
  bool get isReceived => sessionType == SessionType.received;
  SessionType get type => sessionType;

  String get scheduledAtText => _formatDateTime(scheduledAt);
  String get acceptedAtText => _formatDateTime(acceptedAt);
  String get completedAtText => _formatDateTime(completedAt);
  String get createdAtText => _formatDateTime(createdAt);

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '';

    final localDateTime = dateTime.toLocal();
    final year = localDateTime.year.toString().padLeft(4, '0');
    final month = localDateTime.month.toString().padLeft(2, '0');
    final day = localDateTime.day.toString().padLeft(2, '0');
    final hour = localDateTime.hour.toString().padLeft(2, '0');
    final minute = localDateTime.minute.toString().padLeft(2, '0');

    return '$year-$month-$day $hour:$minute';
  }
}
