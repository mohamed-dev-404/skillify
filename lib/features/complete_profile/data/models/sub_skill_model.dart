import 'package:skillify/core/constants/api_keys.dart';

/// A sub skill under a main skill (e.g. "Flutter" under "Programming").
class SubSkillModel {
  final int id;
  final String name;
  final String? iconKey;

  const SubSkillModel({
    required this.id,
    required this.name,
    this.iconKey,
  });

  factory SubSkillModel.fromJson(Map<String, dynamic> json) {
    return SubSkillModel(
      id: (json[ApiKeys.id] as num).toInt(),
      name: json[ApiKeys.name] as String? ?? '',
      iconKey: json[ApiKeys.iconKey] as String?,
    );
  }
}
