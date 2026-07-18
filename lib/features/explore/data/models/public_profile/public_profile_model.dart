import 'package:skillify/features/explore/data/models/public_profile/public_profile_badge_model.dart';
import 'package:skillify/features/explore/data/models/public_profile/public_profile_language_model.dart';
import 'package:skillify/features/explore/data/models/public_profile/public_profile_review_model.dart';
import 'package:skillify/features/explore/data/models/public_profile/public_profile_skill_model.dart';

class PublicProfileModel {
  const PublicProfileModel({
    this.userId,
    this.fullName,
    this.bio,
    this.profilePictureUrl,
    this.jobTitle,
    this.creditBalance,
    this.badges = const [],
    this.languages = const [],
    this.offeredSkill,
    this.neededSkills = const [],
    this.completedSessions,
    this.receivedReviews = const [],
    this.overallRatingScore,
  });

  factory PublicProfileModel.fromJson(Map<String, dynamic> json) {
    final badges = json['badges'] as List<dynamic>? ?? const [];
    final languages = json['languages'] as List<dynamic>? ?? const [];
    final neededSkills = json['neededSkills'] as List<dynamic>? ?? const [];
    final receivedReviews =
        json['receivedReviews'] as List<dynamic>? ?? const [];
    final offeredSkill = json['offeredSkill'] as Map<String, dynamic>?;

    return PublicProfileModel(
      userId: (json['userID'] as num?)?.toInt(),
      fullName: json['fullName'] as String?,
      bio: json['bio'] as String?,
      profilePictureUrl: json['profilePictureUrl'] as String?,
      jobTitle: json['jobTitle'] as String?,
      creditBalance: (json['creditBalance'] as num?)?.toInt(),
      badges: badges
          .whereType<Map<String, dynamic>>()
          .map(PublicProfileBadgeModel.fromJson)
          .toList(),
      languages: languages
          .whereType<Map<String, dynamic>>()
          .map(PublicProfileLanguageModel.fromJson)
          .toList(),
      offeredSkill: offeredSkill == null
          ? null
          : PublicProfileSkillModel.fromJson(offeredSkill),
      neededSkills: neededSkills
          .whereType<Map<String, dynamic>>()
          .map(PublicProfileSkillModel.fromJson)
          .toList(),
      completedSessions: json['completedSessions']?.toString(),
      receivedReviews: receivedReviews
          .whereType<Map<String, dynamic>>()
          .map(PublicProfileReviewModel.fromJson)
          .toList(),
      overallRatingScore: json['overallRatingScore'] as num?,
    );
  }

  final int? userId;
  final String? fullName;
  final String? bio;
  final String? profilePictureUrl;
  final String? jobTitle;
  final int? creditBalance;
  final List<PublicProfileBadgeModel> badges;
  final List<PublicProfileLanguageModel> languages;
  final PublicProfileSkillModel? offeredSkill;
  final List<PublicProfileSkillModel> neededSkills;
  final String? completedSessions;
  final List<PublicProfileReviewModel> receivedReviews;
  final num? overallRatingScore;
}
