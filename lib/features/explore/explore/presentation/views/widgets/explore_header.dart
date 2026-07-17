import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/assets/app_images.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/features/settings/presentation/views/settings_view.dart';

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
              Image.asset(
                AppImages.logoPng,
                width: 180,
              ),
              const Gap(8),
              Text(
                'Find the right skill partner for you',
                style: AppStyles.regular14.copyWith(
                  color: AppColors.textSecondaryNormal,
                ),
              ),
            ],
          ),
        ),
        // Amazing icon for go to settings
        Container(
          decoration: BoxDecoration(
            color: AppColors.secondaryLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.borderNormal,
              width: 2,
            ),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsView()),
              );
            },
            splashRadius: 22,
            padding: const EdgeInsets.all(10),
            icon: const Icon(
              Icons.settings_rounded,
              color: AppColors.secondaryDark,
              size: 22,
            ),
          ),
        ),
      ],
    );
  }
}
