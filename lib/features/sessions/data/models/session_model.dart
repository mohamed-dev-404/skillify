import 'package:skillify/core/constants/api_keys.dart';
import 'package:skillify/core/functions/format_date_time.dart';

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
      scheduledAt: _parseDate(json[ApiKeys.scheduledAt] as String?),
      acceptedAt: _parseDate(json[ApiKeys.acceptedAt] as String?),
      completedAt: _parseDate(json[ApiKeys.completedAt] as String?),
      createdAt:
          _parseDate(json[ApiKeys.createdAt] as String?) ?? DateTime.now(),
      zegoRoomId: json[ApiKeys.zegoRoomId] as String?,
      userRated: json[ApiKeys.userRated] as bool? ?? false,
      userCanRate: json[ApiKeys.userCanRate] as bool? ?? false,
      userRatingScore: json[ApiKeys.userRatingScore] as num? ?? 0,
      sessionType: type,
      pendingRescheduleByUser:
          json[ApiKeys.pendingRescheduleByUser] as bool? ?? false,
    );
  }

  static DateTime? _parseDate(String? dateStr) {
    if (dateStr == null) return null;
    if (!dateStr.toUpperCase().endsWith('Z')) {
      dateStr = '${dateStr}Z';
    }
    return DateTime.parse(dateStr);
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

  String get scheduledAtText => formatDateTime(scheduledAt);
  String get acceptedAtText => formatDateTime(acceptedAt);
  String get completedAtText => formatDateTime(completedAt);
  String get createdAtText => formatDateTime(createdAt);
}
