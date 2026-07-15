class ReviewerModel {
  final int? userId;
  final String? fullName;
  final String? profilePictureUrl;

  ReviewerModel({
    this.userId,
    this.fullName,
    this.profilePictureUrl,
  });

  factory ReviewerModel.fromJson(Map<String, dynamic> json) => ReviewerModel(
        userId: json['userId'] as int?,
        fullName: json['fullName'] as String?,
        profilePictureUrl: json['profilePictureUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'fullName': fullName,
        'profilePictureUrl': profilePictureUrl,
      };
}

class ReviewModel {
  final int? id;
  final int? sessionId;
  final int? score;
  final String? reviewText;
  final String? createdAt;
  final ReviewerModel? reviewer;

  ReviewModel({
    this.id,
    this.sessionId,
    this.score,
    this.reviewText,
    this.createdAt,
    this.reviewer,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        id: json['id'] as int?,
        sessionId: json['sessionId'] as int?,
        score: json['score'] as int?,
        reviewText: json['reviewText'] as String?,
        createdAt: json['createdAt'] as String?,
        reviewer: json['reviewer'] == null
            ? null
            : ReviewerModel.fromJson(json['reviewer'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'sessionId': sessionId,
        'score': score,
        'reviewText': reviewText,
        'createdAt': createdAt,
        'reviewer': reviewer?.toJson(),
      };
}
