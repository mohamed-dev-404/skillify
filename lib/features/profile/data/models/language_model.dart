class LanguageModel {
  final int? id;
  final String? name;
  final String? code;

  LanguageModel({
    this.id,
    this.name,
    this.code,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        code: json['code'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'code': code,
      };
}
