class RequestSessionRequest {
  const RequestSessionRequest({
    this.helperId,
    this.mainSkillId,
    this.topic,
    this.problemDescription,
    this.durationMinutes,
    this.scheduledAt,
  });

  final int? helperId;
  final int? mainSkillId;
  final String? topic;
  final String? problemDescription;
  final int? durationMinutes;
  final DateTime? scheduledAt;

  Map<String, dynamic> toJson() {
    final trimmedTopic = topic?.trim();
    final trimmedDescription = problemDescription?.trim();

    return {
      if (helperId != null) 'helperId': helperId,
      if (mainSkillId != null) 'mainSkillId': mainSkillId,
      if (trimmedTopic != null && trimmedTopic.isNotEmpty)
        'topic': trimmedTopic,
      if (trimmedDescription != null && trimmedDescription.isNotEmpty)
        'problemDescription': trimmedDescription,
      if (durationMinutes != null) 'durationMinutes': durationMinutes,
      if (scheduledAt != null)
        'scheduledAt': scheduledAt!.toUtc().toIso8601String(),
    };
  }

  RequestSessionRequest copyWith({
    Object? helperId = _unset,
    Object? mainSkillId = _unset,
    Object? topic = _unset,
    Object? problemDescription = _unset,
    Object? durationMinutes = _unset,
    Object? scheduledAt = _unset,
  }) {
    return RequestSessionRequest(
      helperId: identical(helperId, _unset) ? this.helperId : helperId as int?,
      mainSkillId: identical(mainSkillId, _unset)
          ? this.mainSkillId
          : mainSkillId as int?,
      topic: identical(topic, _unset) ? this.topic : topic as String?,
      problemDescription: identical(problemDescription, _unset)
          ? this.problemDescription
          : problemDescription as String?,
      durationMinutes: identical(durationMinutes, _unset)
          ? this.durationMinutes
          : durationMinutes as int?,
      scheduledAt: identical(scheduledAt, _unset)
          ? this.scheduledAt
          : scheduledAt as DateTime?,
    );
  }
}

const Object _unset = Object();
