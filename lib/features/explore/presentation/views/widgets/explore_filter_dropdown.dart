import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';

class ExploreFilterDropdown extends StatelessWidget {
  const ExploreFilterDropdown({
    super.key,
    required this.label,
    required this.icon,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final IconData icon;
  final String hint;
  final int? value;
  final List<ExploreFilterOption> items;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    final uniqueItems = {
      for (final item in items) item.id: item,
    }.values.toList();
    final selectedValue = uniqueItems.any((item) => item.id == value)
        ? value
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyles.bold14),
        const Gap(8),
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: AppColors.backgroundNormal,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderNormal),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: AppColors.textSecondaryNormal,
              ),
              const Gap(12),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: selectedValue,
                    isExpanded: true,
                    menuMaxHeight: 280,
                    borderRadius: BorderRadius.circular(12),
                    icon: const Icon(LineIcons.angleDown, size: 16),
                    hint: Text(
                      hint,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.regular14.copyWith(
                        color: AppColors.textSecondaryNormal,
                      ),
                    ),
                    selectedItemBuilder: (_) => uniqueItems
                        .map(
                          (item) => Align(
                            alignment: Alignment.centerLeft,
                            child: _DropdownText(item.name),
                          ),
                        )
                        .toList(),
                    items: uniqueItems
                        .map(
                          (item) => DropdownMenuItem(
                            value: item.id,
                            child: _DropdownText(item.name),
                          ),
                        )
                        .toList(),
                    onChanged: onChanged,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ExploreFilterOption {
  const ExploreFilterOption({required this.id, required this.name});

  final int id;
  final String name;
}

class _DropdownText extends StatelessWidget {
  const _DropdownText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: AppStyles.regular14,
    );
  }
}
