import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';

/// Title + subtitle shown at the top of every complete profile step.
class StepTitle extends StatelessWidget {
  const StepTitle({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppStyles.bold28.copyWith(color: AppColors.primary)),
        const Gap(12),
        Text(
          subtitle,
          style: AppStyles.regular14.copyWith(
            color: AppColors.textSecondaryNormal,
          ),
        ),
      ],
    );
  }
}
