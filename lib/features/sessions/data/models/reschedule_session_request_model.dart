import 'package:skillify/core/constants/api_keys.dart';

class RescheduleSessionRequestModel {
  final DateTime newScheduledAt;
  final String comment;

  const RescheduleSessionRequestModel({
    required this.newScheduledAt,
    required this.comment,
  });

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.newScheduledAt: newScheduledAt.toIso8601String(),
      ApiKeys.comment: comment,
    };
  }
}
