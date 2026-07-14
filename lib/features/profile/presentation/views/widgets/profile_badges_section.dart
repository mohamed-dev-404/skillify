import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/empty_state_widget.dart';
import 'package:skillify/features/profile/data/models/badge_model.dart';

class ProfileBadgesSection extends StatelessWidget {
  final List<BadgeModel>? badges;

  const ProfileBadgesSection({super.key, this.badges});

  @override
  Widget build(BuildContext context) {
    final hasBadges = badges != null && badges!.isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundNormal,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: AppColors.borderNormal),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.military_tech_outlined,
                color: AppColors.warningNormal,
                size: 22,
              ),
              const Gap(8),
              Text(
                'Badges',
                style: AppStyles.bold16.copyWith(
                  color: AppColors.textPrimaryNormal,
                ),
              ),
            ],
          ),
          const Gap(16),
          if (!hasBadges)
            const Center(
              child: EmptyStateWidget(
                title: 'No Badges Earned',
                subtitle: 'Earn badges by completing sessions and helping others!',
                lottieHeight: 100,
                padding: EdgeInsets.symmetric(vertical: 8),
              ),
            )
          else
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: badges!.map((badge) => _BadgeTile(badge: badge)).toList(),
            ),
        ],
      ),
    );
  }
}

class _BadgeTile extends StatelessWidget {
  final BadgeModel badge;

  const _BadgeTile({required this.badge});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.warningLight,
            AppColors.backgroundNormal,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.warningLightActive,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.warningLightActive,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.star_rounded,
              color: AppColors.warningNormal,
              size: 22,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  badge.name ?? '',
                  style: AppStyles.bold14.copyWith(
                    color: AppColors.warningDark,
                  ),
                ),
                if (badge.description != null &&
                    badge.description!.isNotEmpty) ...[
                  const Gap(2),
                  Text(
                    badge.description!,
                    style: AppStyles.regular12.copyWith(
                      color: AppColors.textSecondaryNormal,
                      height: 1.3,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
