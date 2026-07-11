class ExploreUserCardData {
  const ExploreUserCardData({
    required this.fullName,
    required this.jobTitle,
    required this.offeredSkill,
    required this.neededSkills,
    this.userId,
    this.imageUrl,
    this.rating,
  });

  factory ExploreUserCardData.fromJson(Map<String, dynamic> json) {
    final offeredSkill = json['offeredMainSkill'] as Map<String, dynamic>?;
    final neededSkills = json['neededMainSkills'] as List<dynamic>? ?? const [];

    return ExploreUserCardData(
      userId: json['userId'] as int?,
      fullName: json['fullName'] as String? ?? '',
      jobTitle: json['jobTitle'] as String? ?? '',
      imageUrl: json['profilePictureUrl'] as String?,
      offeredSkill: offeredSkill?['name'] as String? ?? '',
      neededSkills: neededSkills
          .whereType<Map<String, dynamic>>()
          .map((skill) => skill['name'] as String? ?? '')
          .where((skill) => skill.isNotEmpty)
          .toList(),
      rating: (json['rating'] as num?)?.toDouble(),
    );
  }

  final int? userId;
  final String fullName;
  final String jobTitle;
  final String? imageUrl;
  final String offeredSkill;
  final List<String> neededSkills;
  final double? rating;
}
