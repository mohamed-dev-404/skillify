import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';

class ProfileSkillCard extends StatelessWidget {
  final String title;
  final String mainSkillName;
  final List<String> subSkills;
  final String description;
  final IconData sectionIcon;
  final Color themeColor;

  const ProfileSkillCard({
    super.key,
    required this.title,
    required this.mainSkillName,
    required this.subSkills,
    required this.description,
    required this.sectionIcon,
    this.themeColor = AppColors.secondary,
  });

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
              Icon(
                sectionIcon,
                color: themeColor,
                size: 22,
              ),
              const Gap(8),
              Text(
                title,
                style: AppStyles.bold16.copyWith(
                  color: AppColors.textPrimaryNormal,
                ),
              ),
            ],
          ),
          const Gap(16),
          // Main Skill Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: themeColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: themeColor.withValues(alpha: 0.2),
              ),
            ),
            child: Text(
              mainSkillName,
              style: AppStyles.medium14.copyWith(
                color: themeColor,
              ),
            ),
          ),
          const Gap(14),
          // Sub Skills list
          if (subSkills.isNotEmpty) ...[
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
              children: subSkills.map((subSkill) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.borderNormal),
                  ),
                  child: Text(
                    subSkill,
                    style: AppStyles.regular12.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                );
              }).toList(),
            ),
            const Gap(16),
          ],
          // Description
          if (description.isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.backgroundNormalActive.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                description,
                style: AppStyles.regular14.copyWith(
                  color: AppColors.textSecondaryNormal,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
