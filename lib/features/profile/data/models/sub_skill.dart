class SubSkill {
	int? id;
	String? name;
	dynamic iconKey;

	SubSkill({this.id, this.name, this.iconKey});

	factory SubSkill.fromJson(Map<String, dynamic> json) => SubSkill(
				id: json['id'] as int?,
				name: json['name'] as String?,
				iconKey: json['iconKey'] as dynamic,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'name': name,
				'iconKey': iconKey,
			};
}
