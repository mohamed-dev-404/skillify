import 'package:skillify/core/constants/api_keys.dart';

/// A language returned by `GET /Languages` (used in the languages step).
class LanguageModel {
  final int id;
  final String name;
  final String? code;

  const LanguageModel({
    required this.id,
    required this.name,
    this.code,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      id: (json[ApiKeys.id] as num).toInt(),
      name: json[ApiKeys.name] as String? ?? '',
      code: json[ApiKeys.code] as String?,
    );
  }
}
