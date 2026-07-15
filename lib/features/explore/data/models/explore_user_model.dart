import 'package:skillify/features/explore/data/models/explore_skill_model.dart';

class ExploreUserModel {
  const ExploreUserModel({
    required this.userId,
    required this.fullName,
    required this.neededMainSkills,
    this.jobTitle,
    this.profilePictureUrl,
    this.offeredMainSkill,
  });

  factory ExploreUserModel.fromJson(Map<String, dynamic> json) {
    final offeredSkill = json['offeredMainSkill'] as Map<String, dynamic>?;
    final neededSkills = json['neededMainSkills'] as List<dynamic>? ?? const [];

    return ExploreUserModel(
      userId: (json['userId'] as num).toInt(),
      fullName: json['fullName'] as String? ?? '',
      jobTitle: json['jobTitle'] as String?,
      profilePictureUrl: json['profilePictureUrl'] as String?,
      offeredMainSkill: offeredSkill == null
          ? null
          : ExploreSkillModel.fromJson(offeredSkill),
      neededMainSkills: neededSkills
          .whereType<Map<String, dynamic>>()
          .map(ExploreSkillModel.fromJson)
          .toList(),
    );
  }

  final int userId;
  final String fullName;
  final String? jobTitle;
  final String? profilePictureUrl;
  final ExploreSkillModel? offeredMainSkill;
  final List<ExploreSkillModel> neededMainSkills;
}
