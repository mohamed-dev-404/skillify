import 'package:flutter/material.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'label.dart';

class DurationSelector extends StatelessWidget {
  const DurationSelector({
    required this.selectedMinutes,
    required this.onChanged,
    super.key,
  });

  final int selectedMinutes;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    const durations = [15, 30, 60];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Label('Session Duration'),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColors.primaryLight.withValues(alpha: 0.65),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: durations.map((minutes) {
              final isSelected = selectedMinutes == minutes;

              return Expanded(
                child: InkWell(
                  onTap: () => onChanged(minutes),
                  borderRadius: BorderRadius.circular(9),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Text(
                      '$minutes Min',
                      style: AppStyles.bold16.copyWith(
                        color: isSelected
                            ? AppColors.backgroundNormal
                            : AppColors.textSecondaryNormal,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
