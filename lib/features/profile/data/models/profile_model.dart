import 'badge_model.dart';
import 'language_model.dart';
import 'needed_skill.dart';
import 'offered_skill.dart';
import 'review_model.dart';

class ProfileModel {
	int? userId;
	String? fullName;
	String? bio;
	String? profilePictureUrl;
	String? jobTitle;
	int? creditBalance;
	List<BadgeModel>? badges;
	List<LanguageModel>? languages;
	OfferedSkill? offeredSkill;
	List<NeededSkill>? neededSkills;
	String? completedSessions;
	List<ReviewModel>? receivedReviews;
	num? overallRatingScore;

	ProfileModel({
		this.userId,
		this.fullName,
		this.bio,
		this.profilePictureUrl,
		this.jobTitle,
		this.creditBalance,
		this.badges,
		this.languages,
		this.offeredSkill,
		this.neededSkills,
		this.completedSessions,
		this.receivedReviews,
		this.overallRatingScore,
	});

	factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
				userId: json['userID'] as int?,
				fullName: json['fullName'] as String?,
				bio: json['bio'] as String?,
				profilePictureUrl: json['profilePictureUrl'] as String?,
				jobTitle: json['jobTitle'] as String?,
				creditBalance: json['creditBalance'] as int?,
				badges: (json['badges'] as List<dynamic>?)
						?.map((e) => BadgeModel.fromJson(e as Map<String, dynamic>))
						.toList(),
				languages: (json['languages'] as List<dynamic>?)
						?.map((e) => LanguageModel.fromJson(e as Map<String, dynamic>))
						.toList(),
				offeredSkill: json['offeredSkill'] == null
						? null
						: OfferedSkill.fromJson(json['offeredSkill'] as Map<String, dynamic>),
				neededSkills: (json['neededSkills'] as List<dynamic>?)
						?.map((e) => NeededSkill.fromJson(e as Map<String, dynamic>))
						.toList(),
				completedSessions: json['completedSessions'] as String?,
				receivedReviews: (json['receivedReviews'] as List<dynamic>?)
						?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
						.toList(),
				overallRatingScore: json['overallRatingScore'] as num?,
			);

	Map<String, dynamic> toJson() => {
				'userID': userId,
				'fullName': fullName,
				'bio': bio,
				'profilePictureUrl': profilePictureUrl,
				'jobTitle': jobTitle,
				'creditBalance': creditBalance,
				'badges': badges?.map((e) => e.toJson()).toList(),
				'languages': languages?.map((e) => e.toJson()).toList(),
				'offeredSkill': offeredSkill?.toJson(),
				'neededSkills': neededSkills?.map((e) => e.toJson()).toList(),
				'completedSessions': completedSessions,
				'receivedReviews': receivedReviews?.map((e) => e.toJson()).toList(),
				'overallRatingScore': overallRatingScore,
			};
}
