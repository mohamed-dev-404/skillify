import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';

class SessionRatingIndicator extends StatelessWidget {
  const SessionRatingIndicator({
    super.key,
    required this.score,
  });

  final double score;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.star_rounded,
          size: 18,
          color: AppColors.warningNormal,
        ),
        const Gap(4),
        Text(
          score.toStringAsFixed(1),
          style: AppStyles.medium14.copyWith(
            color: AppColors.warningDark,
          ),
        ),
        const Gap(6),
        Text(
          'Your rating',
          style: AppStyles.regular12.copyWith(
            color: AppColors.textSecondaryNormal,
          ),
        ),
      ],
    );
  }
}

class RateSessionPlaceholder extends StatelessWidget {
  const RateSessionPlaceholder({
    super.key,
    required this.sessionId,
  });

  final int sessionId;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Navigate to rating screen when implemented
        },
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.warningLight,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.star_outline_rounded,
                size: 18,
                color: AppColors.warningDark,
              ),
              const Gap(6),
              Text(
                'Rate Session',
                style: AppStyles.medium14.copyWith(
                  color: AppColors.warningDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
