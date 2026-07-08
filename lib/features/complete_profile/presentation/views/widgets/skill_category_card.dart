import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/custom_svg_picture.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/complete_profile_items.dart';

/// Selectable category card used in the "what can you teach / learn" steps.
class SkillCategoryCard extends StatelessWidget {
  const SkillCategoryCard({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final SkillCategoryItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.secondaryLight
              : AppColors.backgroundNormal,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.secondary : AppColors.backgroundDark,
          ),
        ),
        child: Row(
          children: [
            CustomSvgPicture(
              path: item.iconPath,
              width: 24,
              height: 24,
              color: isSelected
                  ? AppColors.secondary
                  : AppColors.textSecondaryNormal,
            ),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: AppStyles.medium20.copyWith(color: AppColors.primary),
                  ),
                  const Gap(2),
                  Text(
                    item.subtitle,
                    style: AppStyles.regular14.copyWith(
                      color: AppColors.textSecondaryNormal,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(8),
            _RadioIndicator(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}

class _RadioIndicator extends StatelessWidget {
  const _RadioIndicator({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? AppColors.secondary : Colors.transparent,
        border: Border.all(
          color: isSelected ? AppColors.secondary : AppColors.borderDark,
          width: 1.5,
        ),
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.backgroundNormal,
                ),
              ),
            )
          : null,
    );
  }
}
