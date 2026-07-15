import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/empty_state_widget.dart';
import 'package:skillify/features/explore/data/models/public_profile/public_profile_badge_model.dart';
import 'package:skillify/features/explore/data/models/public_profile/public_profile_language_model.dart';
import 'package:skillify/features/explore/data/models/public_profile/public_profile_review_model.dart';
import 'package:skillify/features/explore/data/models/public_profile/public_profile_skill_model.dart';

class PublicProfileLanguagesSection extends StatelessWidget {
  const PublicProfileLanguagesSection({super.key, required this.languages});

  final List<PublicProfileLanguageModel> languages;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      icon: Icons.language_outlined,
      iconColor: AppColors.accent,
      title: 'Languages',
      child: languages.isEmpty
          ? const _SectionEmptyState(
              title: 'No Languages Added',
              subtitle: 'This member has not added languages yet.',
            )
          : Wrap(
              spacing: 8,
              runSpacing: 8,
              children: languages.map((language) {
                return _LanguageChip(language: language);
              }).toList(),
            ),
    );
  }
}

class PublicProfileSkillSection extends StatelessWidget {
  const PublicProfileSkillSection({
    super.key,
    required this.title,
    required this.icon,
    required this.themeColor,
    this.skill,
  });

  final String title;
  final IconData icon;
  final Color themeColor;
  final PublicProfileSkillModel? skill;

  @override
  Widget build(BuildContext context) {
    final mainSkillName = skill?.mainSkill?.name;
    final hasMainSkill = mainSkillName != null && mainSkillName.isNotEmpty;
    final description = skill?.description?.trim();

    return _SectionCard(
      icon: icon,
      iconColor: themeColor,
      title: title,
      child: !hasMainSkill
          ? const _SectionEmptyState(
              title: 'No Skills Added',
              subtitle: 'No skills have been listed in this section yet.',
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _MainSkillBadge(
                  text: mainSkillName,
                  color: themeColor,
                ),
                if (skill!.subSkills.isNotEmpty) ...[
                  const Gap(14),
                  Text(
                    'Specific areas:',
                    style: AppStyles.medium12.copyWith(
                      color: AppColors.textSecondaryNormal,
                    ),
                  ),
                  const Gap(8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: skill!.subSkills.map((subSkill) {
                      return _SubSkillChip(text: subSkill.name ?? '');
                    }).toList(),
                  ),
                ],
                if (description != null && description.isNotEmpty) ...[
                  const Gap(16),
                  _DescriptionBox(text: description),
                ],
              ],
            ),
    );
  }
}

class PublicProfileBadgesSection extends StatelessWidget {
  const PublicProfileBadgesSection({super.key, required this.badges});

  final List<PublicProfileBadgeModel> badges;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      icon: Icons.military_tech_outlined,
      iconColor: AppColors.warningNormal,
      title: 'Badges',
      child: badges.isEmpty
          ? const _SectionEmptyState(
              title: 'No Badges Earned',
              subtitle: 'Badges will appear here after completed sessions.',
            )
          : Column(
              children: badges.map((badge) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _BadgeTile(badge: badge),
                );
              }).toList(),
            ),
    );
  }
}

class PublicProfileReviewsSection extends StatelessWidget {
  const PublicProfileReviewsSection({
    super.key,
    required this.reviews,
    this.overallRatingScore,
  });

  final List<PublicProfileReviewModel> reviews;
  final num? overallRatingScore;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      icon: Icons.rate_review_outlined,
      iconColor: AppColors.secondary,
      title: 'Reviews',
      trailing: overallRatingScore == null
          ? null
          : _RatingBadge(score: overallRatingScore!),
      child: reviews.isEmpty
          ? const _SectionEmptyState(
              title: 'No Reviews Yet',
              subtitle: 'Reviews from sessions will appear here.',
            )
          : Column(
              children: reviews.asMap().entries.map((entry) {
                final isLast = entry.key == reviews.length - 1;

                return Column(
                  children: [
                    _ReviewTile(review: entry.value),
                    if (!isLast) ...[
                      const Gap(12),
                      const Divider(color: AppColors.borderNormal, height: 1),
                      const Gap(12),
                    ],
                  ],
                );
              }).toList(),
            ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.child,
    this.trailing,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
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
              Icon(icon, color: iconColor, size: 22),
              const Gap(8),
              Text(
                title,
                style: AppStyles.bold16.copyWith(
                  color: AppColors.textPrimaryNormal,
                ),
              ),
              const Spacer(),
              if (trailing != null) trailing!,
            ],
          ),
          const Gap(16),
          child,
        ],
      ),
    );
  }
}

class _LanguageChip extends StatelessWidget {
  const _LanguageChip({required this.language});

  final PublicProfileLanguageModel language;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.accentLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.accentLightActive),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            language.code?.toUpperCase() ?? '',
            style: AppStyles.bold12.copyWith(
              color: AppColors.accentDark,
            ),
          ),
          const Gap(6),
          Container(
            width: 1,
            height: 12,
            color: AppColors.accentLightActive,
          ),
          const Gap(6),
          Text(
            language.name ?? '',
            style: AppStyles.medium12.copyWith(
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }
}

class _MainSkillBadge extends StatelessWidget {
  const _MainSkillBadge({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        text,
        style: AppStyles.medium14.copyWith(color: color),
      ),
    );
  }
}

class _SubSkillChip extends StatelessWidget {
  const _SubSkillChip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.borderNormal),
      ),
      child: Text(
        text,
        style: AppStyles.regular12.copyWith(color: AppColors.primary),
      ),
    );
  }
}

class _DescriptionBox extends StatelessWidget {
  const _DescriptionBox({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backgroundNormalActive.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: AppStyles.regular14.copyWith(
          color: AppColors.textSecondaryNormal,
          height: 1.4,
        ),
      ),
    );
  }
}

class _BadgeTile extends StatelessWidget {
  const _BadgeTile({required this.badge});

  final PublicProfileBadgeModel badge;

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
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.warningLightActive),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.star_rounded,
            color: AppColors.warningNormal,
            size: 22,
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

class _ReviewTile extends StatelessWidget {
  const _ReviewTile({required this.review});

  final PublicProfileReviewModel review;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ReviewerAvatar(imageUrl: review.reviewer?.profilePictureUrl),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      review.reviewer?.fullName ?? 'Anonymous',
                      style: AppStyles.bold14.copyWith(
                        color: AppColors.textPrimaryNormal,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Gap(8),
                  _StarScore(score: review.score ?? 0),
                ],
              ),
              if (review.reviewText != null &&
                  review.reviewText!.isNotEmpty) ...[
                const Gap(6),
                Text(
                  review.reviewText!,
                  style: AppStyles.regular14.copyWith(
                    color: AppColors.textSecondaryNormal,
                    height: 1.4,
                  ),
                ),
              ],
              if (review.createdAt != null &&
                  review.createdAt!.trim().isNotEmpty) ...[
                const Gap(6),
                Text(
                  _formatDate(review.createdAt!),
                  style: AppStyles.regular12.copyWith(
                    color: AppColors.textSecondaryNormal,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];

      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    } catch (_) {
      return isoDate;
    }
  }
}

class _ReviewerAvatar extends StatelessWidget {
  const _ReviewerAvatar({this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.borderNormal),
      ),
      child: ClipOval(
        child: Image.network(
          imageUrl ?? '',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: AppColors.primaryLight,
            child: const Icon(
              Icons.person,
              size: 24,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}

class _StarScore extends StatelessWidget {
  const _StarScore({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    final visibleScore = score.clamp(0, 5);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < visibleScore
              ? Icons.star_rounded
              : Icons.star_outline_rounded,
          size: 14,
          color: AppColors.warningNormal,
        );
      }),
    );
  }
}

class _RatingBadge extends StatelessWidget {
  const _RatingBadge({required this.score});

  final num score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.warningLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.warningLightActive),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star_rounded,
            color: AppColors.warningNormal,
            size: 15,
          ),
          const Gap(4),
          Text(
            score.toStringAsFixed(1),
            style: AppStyles.bold12.copyWith(color: AppColors.warningDark),
          ),
        ],
      ),
    );
  }
}

class _SectionEmptyState extends StatelessWidget {
  const _SectionEmptyState({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: EmptyStateWidget(
        title: title,
        subtitle: subtitle,
        lottieHeight: 100,
        padding: const EdgeInsets.symmetric(vertical: 8),
      ),
    );
  }
}
