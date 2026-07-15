import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/features/explore/data/models/public_profile/public_profile_model.dart';

class PublicProfileHeaderCard extends StatelessWidget {
  const PublicProfileHeaderCard({
    super.key,
    required this.profile,
  });

  final PublicProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundNormal,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.06),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.borderNormal),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _ProfileAvatar(imageUrl: profile.profilePictureUrl),
              const Gap(16),
              Expanded(
                child: _ProfileIdentity(profile: profile),
              ),
            ],
          ),
          if (profile.bio != null && profile.bio!.trim().isNotEmpty) ...[
            const Gap(16),
            const Divider(color: AppColors.borderNormal, height: 1),
            const Gap(16),
            Text(
              profile.bio!.trim(),
              style: AppStyles.regular14.copyWith(
                color: AppColors.textSecondaryNormal,
                height: 1.45,
              ),
            ),
          ],
          const Gap(18),
          _PublicProfileStats(profile: profile),
        ],
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 82,
      height: 82,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.secondary,
          width: 2.5,
        ),
      ),
      child: ClipOval(
        child: Image.network(
          imageUrl ?? '',
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;

            return const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.secondary,
                  ),
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.primaryLight,
              child: const Icon(
                LineIcons.user,
                size: 38,
                color: AppColors.primary,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ProfileIdentity extends StatelessWidget {
  const _ProfileIdentity({required this.profile});

  final PublicProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          profile.fullName ?? 'No Name',
          style: AppStyles.bold20.copyWith(
            color: AppColors.textPrimaryNormal,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const Gap(5),
        Text(
          profile.jobTitle ?? 'Skillify Member',
          style: AppStyles.medium14.copyWith(
            color: AppColors.secondaryDark,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _PublicProfileStats extends StatelessWidget {
  const _PublicProfileStats({required this.profile});

  final PublicProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatTile(
            icon: LineIcons.star,
            label: 'Rating',
            value: _ratingText(profile.overallRatingScore),
            backgroundColor: AppColors.warningLight,
            iconColor: AppColors.warningNormal,
            valueColor: AppColors.warningDark,
          ),
        ),
        const Gap(12),
        Expanded(
          child: _StatTile(
            icon: LineIcons.history,
            label: 'Sessions',
            value: '${profile.completedSessions ?? 0} Done',
            backgroundColor: AppColors.primaryLight,
            iconColor: AppColors.primary,
            valueColor: AppColors.primaryActive,
          ),
        ),
      ],
    );
  }

  String _ratingText(num? rating) {
    if (rating == null) return 'New';
    return rating.toStringAsFixed(1);
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.backgroundColor,
    required this.iconColor,
    required this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color backgroundColor;
  final Color iconColor;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 19),
          const Gap(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppStyles.regular12.copyWith(
                    color: AppColors.textSecondaryNormal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  value,
                  style: AppStyles.bold14.copyWith(
                    color: valueColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
