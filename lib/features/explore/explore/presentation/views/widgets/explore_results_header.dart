import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';

class ExploreResultsHeader extends StatelessWidget {
  const ExploreResultsHeader({super.key, required this.resultsCount});

  final int resultsCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('People for you', style: AppStyles.bold20),
            const Spacer(),
            Text(
              '$resultsCount matches',
              style: AppStyles.medium12.copyWith(
                color: AppColors.textSecondaryNormal,
              ),
            ),
          ],
        ),
        const Gap(6),
        Text(
          'Discover people to learn from and exchange skills with.',
          style: AppStyles.regular14.copyWith(
            color: AppColors.textSecondaryNormal,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}
