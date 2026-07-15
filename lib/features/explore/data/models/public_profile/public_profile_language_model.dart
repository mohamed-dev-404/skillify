class PublicProfileLanguageModel {
  const PublicProfileLanguageModel({
    this.id,
    this.name,
    this.code,
  });

  factory PublicProfileLanguageModel.fromJson(Map<String, dynamic> json) {
    return PublicProfileLanguageModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      code: json['code'] as String?,
    );
  }

  final int? id;
  final String? name;
  final String? code;
}
