class PublicProfileBadgeModel {
  const PublicProfileBadgeModel({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.iconKey,
  });

  factory PublicProfileBadgeModel.fromJson(Map<String, dynamic> json) {
    return PublicProfileBadgeModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      iconKey: json['iconKey'] as String?,
    );
  }

  final int? id;
  final String? name;
  final String? slug;
  final String? description;
  final String? iconKey;
}
