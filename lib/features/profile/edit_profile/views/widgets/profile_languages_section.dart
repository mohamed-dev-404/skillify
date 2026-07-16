import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/empty_state_widget.dart';
import 'package:skillify/features/profile/data/models/language_model.dart';

class ProfileLanguagesSection extends StatelessWidget {
  final List<LanguageModel>? languages;

  const ProfileLanguagesSection({super.key, this.languages});

  @override
  Widget build(BuildContext context) {
    final hasLanguages = languages != null && languages!.isNotEmpty;

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
                Icons.language_outlined,
                color: AppColors.accent,
                size: 22,
              ),
              const Gap(8),
              Text(
                'Languages',
                style: AppStyles.bold16.copyWith(
                  color: AppColors.textPrimaryNormal,
                ),
              ),
            ],
          ),
          const Gap(14),
          if (!hasLanguages)
            const Center(
              child: EmptyStateWidget(
                title: 'No Languages Added',
                subtitle: 'You haven\'t added any languages to your profile yet.',
                lottieHeight: 100,
                padding: EdgeInsets.symmetric(vertical: 8),
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: languages!.map((lang) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accentLight,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.accentLightActive,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        lang.code?.toUpperCase() ?? '',
                        style: AppStyles.bold12.copyWith(
                          color: AppColors.accentDark,
                          letterSpacing: 0.5,
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
                        lang.name ?? '',
                        style: AppStyles.medium12.copyWith(
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
