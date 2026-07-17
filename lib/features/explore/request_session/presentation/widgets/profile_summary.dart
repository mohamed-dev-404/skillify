import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/features/explore/data/models/public_profile/public_profile_model.dart';

class ProfileSummary extends StatelessWidget {
  const ProfileSummary({required this.profile, super.key});

  final PublicProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundNormal,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderNormal),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Avatar(imageUrl: profile.profilePictureUrl),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.fullName ?? 'No Name',
                  style: AppStyles.bold20.copyWith(color: AppColors.primary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(4),
                Text(
                  profile.jobTitle ?? 'Skillify Member',
                  style: AppStyles.regular14.copyWith(
                    color: AppColors.textSecondaryNormal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Gap(12),
          RatingBadge(score: profile.overallRatingScore),
        ],
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({this.imageUrl, Key? key}) : super(key: key);

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      height: 76,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.secondary, width: 2),
      ),
      child: ClipOval(
        child: Image.network(
          imageUrl ?? '',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: AppColors.primaryLight,
            child: const Icon(LineIcons.user, color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}

class RatingBadge extends StatelessWidget {
  const RatingBadge({this.score, Key? key}) : super(key: key);

  final num? score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star_outline_rounded,
            color: AppColors.warningNormal,
          ),
          const Gap(4),
          Text(
            score?.toStringAsFixed(1) ?? 'New',
            style: AppStyles.bold16.copyWith(
              color: AppColors.textPrimaryNormal,
            ),
          ),
        ],
      ),
    );
  }
}
