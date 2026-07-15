class PublicProfileReviewerModel {
  const PublicProfileReviewerModel({
    this.userId,
    this.fullName,
    this.profilePictureUrl,
  });

  factory PublicProfileReviewerModel.fromJson(Map<String, dynamic> json) {
    return PublicProfileReviewerModel(
      userId: (json['userId'] as num?)?.toInt(),
      fullName: json['fullName'] as String?,
      profilePictureUrl: json['profilePictureUrl'] as String?,
    );
  }

  final int? userId;
  final String? fullName;
  final String? profilePictureUrl;
}

class PublicProfileReviewModel {
  const PublicProfileReviewModel({
    this.id,
    this.sessionId,
    this.score,
    this.reviewText,
    this.createdAt,
    this.reviewer,
  });

  factory PublicProfileReviewModel.fromJson(Map<String, dynamic> json) {
    final reviewer = json['reviewer'] as Map<String, dynamic>?;

    return PublicProfileReviewModel(
      id: (json['id'] as num?)?.toInt(),
      sessionId: (json['sessionId'] as num?)?.toInt(),
      score: (json['score'] as num?)?.toInt(),
      reviewText: json['reviewText'] as String?,
      createdAt: json['createdAt'] as String?,
      reviewer: reviewer == null
          ? null
          : PublicProfileReviewerModel.fromJson(reviewer),
    );
  }

  final int? id;
  final int? sessionId;
  final int? score;
  final String? reviewText;
  final String? createdAt;
  final PublicProfileReviewerModel? reviewer;
}
