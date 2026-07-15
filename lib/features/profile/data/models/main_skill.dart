class MainSkill {
	int? id;
	String? name;
	String? slug;
	dynamic iconKey;

	MainSkill({this.id, this.name, this.slug, this.iconKey});

	factory MainSkill.fromJson(Map<String, dynamic> json) => MainSkill(
				id: json['id'] as int?,
				name: json['name'] as String?,
				slug: json['slug'] as String?,
				iconKey: json['iconKey'] as dynamic,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'name': name,
				'slug': slug,
				'iconKey': iconKey,
			};
}
