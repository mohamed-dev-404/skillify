import 'package:skillify/core/constants/api_keys.dart';

/// One needed skill selection: a main skill + the sub skills under it.
class NeededSkillSelection {
  final int mainSkillId;
  final List<int> subSkillIds;

  const NeededSkillSelection({
    required this.mainSkillId,
    this.subSkillIds = const [],
  });

  Map<String, dynamic> toJson() => {
    ApiKeys.mainSkillId: mainSkillId,
    ApiKeys.subSkillIds: subSkillIds,
  };
}

/// Request body for `PUT /Users/me/profile` (JSON).
/// The profile picture is uploaded separately to `PUT /Users/me/profile-picture`.
class CompleteProfileRequestModel {
  final String? bio;
  final String? jobTitle;
  final int offeredMainSkillId;
  final List<int> offeredSubSkillIds;
  final String? offeredDescription;
  final List<NeededSkillSelection> neededSkills;
  final List<int> languageIds;

  const CompleteProfileRequestModel({
    this.bio,
    this.jobTitle,
    required this.offeredMainSkillId,
    this.offeredSubSkillIds = const [],
    this.offeredDescription,
    this.neededSkills = const [],
    this.languageIds = const [],
  });

  Map<String, dynamic> toJson() => {
    if (bio?.isNotEmpty == true) ApiKeys.bio: bio,
    if (jobTitle?.isNotEmpty == true) ApiKeys.jobTitle: jobTitle,
    ApiKeys.offeredMainSkill: offeredMainSkillId,
    ApiKeys.offeredSubSkills: offeredSubSkillIds,
    if (offeredDescription?.isNotEmpty == true)
      ApiKeys.offeredDescription: offeredDescription,
    ApiKeys.neededSkills: [for (final skill in neededSkills) skill.toJson()],
    ApiKeys.languageIds: languageIds,
  };
}
