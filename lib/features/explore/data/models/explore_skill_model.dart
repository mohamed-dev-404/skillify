import 'package:skillify/core/constants/api_keys.dart';

class ExploreSkillModel {
  const ExploreSkillModel({
    required this.id,
    required this.name,
    this.slug,
    this.iconKey,
  });

  factory ExploreSkillModel.fromJson(Map<String, dynamic> json) {
    return ExploreSkillModel(
      id: (json[ApiKeys.id] as num).toInt(),
      name: json[ApiKeys.name] as String? ?? '',
      slug: json[ApiKeys.slug] as String?,
      iconKey: json[ApiKeys.iconKey] as String?,
    );
  }

  final int id;
  final String name;
  final String? slug;
  final String? iconKey;
}
