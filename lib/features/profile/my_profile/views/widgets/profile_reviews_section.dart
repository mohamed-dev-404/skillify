import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/empty_state_widget.dart';
import 'package:skillify/features/profile/data/models/review_model.dart';

class ProfileReviewsSection extends StatelessWidget {
  final List<ReviewModel>? reviews;
  final num? overallRatingScore;

  const ProfileReviewsSection({
    super.key,
    this.reviews,
    this.overallRatingScore,
  });

  @override
  Widget build(BuildContext context) {
    final hasReviews = reviews != null && reviews!.isNotEmpty;

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
          // Section header with overall rating
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.rate_review_outlined,
                  color: AppColors.secondary,
                  size: 20,
                ),
              ),
              const Gap(10),
              Text(
                'Reviews',
                style: AppStyles.bold16.copyWith(
                  color: AppColors.textPrimaryNormal,
                ),
              ),
              const Spacer(),
              if (overallRatingScore != null) ...[
                _OverallRatingBadge(score: overallRatingScore!),
              ],
            ],
          ),
          const Gap(16),
          if (!hasReviews)
            const Center(
              child: EmptyStateWidget(
                title: 'No Reviews Yet',
                subtitle: 'Reviews from your students will appear here.',
                lottieHeight: 100,
                padding: EdgeInsets.symmetric(vertical: 8),
              ),
            )
          else
            ...reviews!.asMap().entries.map((entry) {
              final index = entry.key;
              final review = entry.value;
              return Column(
                children: [
                  _ReviewTile(review: review),
                  if (index < reviews!.length - 1) ...[
                    const Gap(12),
                    const Divider(color: AppColors.borderNormal, height: 1),
                    const Gap(12),
                  ],
                ],
              );
            }),
        ],
      ),
    );
  }
}

class _OverallRatingBadge extends StatelessWidget {
  final num score;

  const _OverallRatingBadge({required this.score});

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
          const Icon(Icons.star_rounded, color: AppColors.warningNormal, size: 15),
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

class _ReviewTile extends StatelessWidget {
  final ReviewModel review;

  const _ReviewTile({required this.review});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Reviewer avatar
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.borderNormal),
          ),
          child: ClipOval(
            child: Image.network(
              review.reviewer?.profilePictureUrl ?? '',
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
        ),
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
                  // Star score
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
              if (review.createdAt != null) ...[
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
      final dt = DateTime.parse(isoDate);
      final months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
      ];
      return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
    } catch (_) {
      return isoDate;
    }
  }
}

class _StarScore extends StatelessWidget {
  final int score;

  const _StarScore({required this.score});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        return Icon(
          i < score ? Icons.star_rounded : Icons.star_outline_rounded,
          size: 14,
          color: AppColors.warningNormal,
        );
      }),
    );
  }
}
