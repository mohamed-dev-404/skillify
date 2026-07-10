import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/assets/app_icons.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/custom_svg_picture.dart';

/// Selectable main skill card used in the "what can you teach / learn" steps.
class SkillCategoryCard extends StatelessWidget {
  const SkillCategoryCard({
    super.key,
    required this.title,
    this.iconPath,
    required this.isSelected,
    required this.onTap,
  });

  final String title;

  /// Falls back to a generic icon (the API iconKey is not ready yet).
  final String? iconPath;
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
              path: iconPath ?? AppIcons.briefcaseSvg,
              width: 24,
              height: 24,
              color: isSelected
                  ? AppColors.secondary
                  : AppColors.textSecondaryNormal,
            ),
            const Gap(16),
            Expanded(
              child: Text(
                title,
                style: AppStyles.medium20.copyWith(color: AppColors.primary),
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
