class PublicProfileMainSkillModel {
  const PublicProfileMainSkillModel({
    this.id,
    this.name,
    this.slug,
    this.iconKey,
  });

  factory PublicProfileMainSkillModel.fromJson(Map<String, dynamic> json) {
    return PublicProfileMainSkillModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      iconKey: json['iconKey'] as String?,
    );
  }

  final int? id;
  final String? name;
  final String? slug;
  final String? iconKey;
}

class PublicProfileSubSkillModel {
  const PublicProfileSubSkillModel({
    this.id,
    this.name,
    this.iconKey,
  });

  factory PublicProfileSubSkillModel.fromJson(Map<String, dynamic> json) {
    return PublicProfileSubSkillModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      iconKey: json['iconKey'] as String?,
    );
  }

  final int? id;
  final String? name;
  final String? iconKey;
}

class PublicProfileSkillModel {
  const PublicProfileSkillModel({
    this.userSkillId,
    this.mainSkill,
    this.subSkills = const [],
    this.description,
  });

  factory PublicProfileSkillModel.fromJson(Map<String, dynamic> json) {
    final mainSkill = json['mainSkill'] as Map<String, dynamic>?;
    final subSkills = json['subSkills'] as List<dynamic>? ?? const [];

    return PublicProfileSkillModel(
      userSkillId: (json['userSkillId'] as num?)?.toInt(),
      mainSkill: mainSkill == null
          ? null
          : PublicProfileMainSkillModel.fromJson(mainSkill),
      subSkills: subSkills
          .whereType<Map<String, dynamic>>()
          .map(PublicProfileSubSkillModel.fromJson)
          .toList(),
      description: json['description'] as String?,
    );
  }

  final int? userSkillId;
  final PublicProfileMainSkillModel? mainSkill;
  final List<PublicProfileSubSkillModel> subSkills;
  final String? description;
}
