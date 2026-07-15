import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';

class ExploreHeader extends StatelessWidget {
  const ExploreHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Explore', style: AppStyles.bold28),
              const Gap(4),
              Text(
                'Find the right skill partner for you',
                style: AppStyles.regular14.copyWith(
                  color: AppColors.textSecondaryNormal,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppColors.secondaryLight,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(
            LineIcons.compass,
            color: AppColors.secondaryDark,
            size: 25,
          ),
        ),
      ],
    );
  }
}
