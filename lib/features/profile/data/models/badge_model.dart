class BadgeModel {
  final int? id;
  final String? name;
  final String? slug;
  final String? description;
  final String? iconKey;

  BadgeModel({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.iconKey,
  });

  factory BadgeModel.fromJson(Map<String, dynamic> json) => BadgeModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        slug: json['slug'] as String?,
        description: json['description'] as String?,
        iconKey: json['iconKey'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
        'description': description,
        'iconKey': iconKey,
      };
}
