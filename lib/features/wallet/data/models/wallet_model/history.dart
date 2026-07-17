class History {
	int? id;
	int? userId;
	int? amount;
	String? type;
	dynamic description;
	DateTime? createdAt;

	History({
		this.id, 
		this.userId, 
		this.amount, 
		this.type, 
		this.description, 
		this.createdAt, 
	});

	factory History.fromJson(Map<String, dynamic> json) => History(
				id: json['id'] as int?,
				userId: json['userId'] as int?,
				amount: json['amount'] as int?,
				type: json['type'] as String?,
				description: json['description'] as dynamic,
				createdAt: json['createdAt'] == null
						? null
						: DateTime.parse(json['createdAt'] as String),
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'userId': userId,
				'amount': amount,
				'type': type,
				'description': description,
				'createdAt': createdAt?.toIso8601String(),
			};
}
