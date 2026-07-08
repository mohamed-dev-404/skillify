import 'package:skillify/core/constants/api_keys.dart';
import 'package:skillify/features/complete_profile/data/models/sub_skill_model.dart';

/// A main skill with its sub skills,
/// returned by `GET /MainSkills/with-subskills`.
class MainSkillModel {
  final int id;
  final String name;
  final String? slug;
  final String? iconKey;
  final List<SubSkillModel> subSkills;

  const MainSkillModel({
    required this.id,
    required this.name,
    this.slug,
    this.iconKey,
    this.subSkills = const [],
  });

  factory MainSkillModel.fromJson(Map<String, dynamic> json) {
    return MainSkillModel(
      id: (json[ApiKeys.id] as num).toInt(),
      name: json[ApiKeys.name] as String? ?? '',
      slug: json[ApiKeys.slug] as String?,
      iconKey: json[ApiKeys.iconKey] as String?,
      subSkills: (json[ApiKeys.subSkills] as List<dynamic>? ?? [])
          .map((e) => SubSkillModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
