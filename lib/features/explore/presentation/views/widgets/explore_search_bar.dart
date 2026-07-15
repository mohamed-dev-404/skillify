import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';

class ExploreSearchBar extends StatelessWidget {
  const ExploreSearchBar({
    super.key,
    required this.controller,
    required this.activeFilters,
    required this.onFilterTap,
    required this.onChanged,
    required this.onSubmitted,
    required this.onClear,
  });

  final TextEditingController controller;
  final int activeFilters;
  final VoidCallback onFilterTap;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 52,
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              textInputAction: TextInputAction.search,
              style: AppStyles.regular14,
              decoration: InputDecoration(
                hintText: 'Search by name...',
                prefixIcon: const Icon(
                  LineIcons.search,
                  size: 21,
                  color: AppColors.textSecondaryNormal,
                ),
                suffixIcon: controller.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: onClear,
                        icon: const Icon(LineIcons.times, size: 18),
                      ),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ),
        const Gap(10),
        _FilterButton(
          activeFilters: activeFilters,
          onTap: onFilterTap,
        ),
      ],
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({required this.activeFilters, required this.onTap});

  final int activeFilters;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasActiveFilters = activeFilters > 0;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: hasActiveFilters
              ? AppColors.primary
              : AppColors.backgroundNormal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(
              color: hasActiveFilters
                  ? AppColors.primary
                  : AppColors.borderNormal,
            ),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(14),
            child: SizedBox(
              width: 52,
              height: 52,
              child: Icon(
                LineIcons.filter,
                size: 22,
                color: hasActiveFilters
                    ? AppColors.backgroundNormal
                    : AppColors.primary,
              ),
            ),
          ),
        ),
        if (hasActiveFilters)
          Positioned(
            top: -5,
            right: -4,
            child: Container(
              width: 19,
              height: 19,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$activeFilters',
                style: AppStyles.bold12.copyWith(
                  color: AppColors.backgroundNormal,
                  fontSize: 10,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
