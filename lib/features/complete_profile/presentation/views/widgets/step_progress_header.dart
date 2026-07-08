import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';

/// Top header of the complete profile flow:
/// "STEP X OF Y" + percentage labels with an animated progress bar.
class StepProgressHeader extends StatelessWidget {
  const StepProgressHeader({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  /// Zero-based index of the current step.
  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    final progress = (currentStep + 1) / totalSteps;
    final labelStyle = AppStyles.bold12.copyWith(
      color: AppColors.primary,
      letterSpacing: 0.5,
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('STEP ${currentStep + 1} OF $totalSteps', style: labelStyle),
            Text('${(progress * 100).round()}%', style: labelStyle),
          ],
        ),
        const Gap(10),
        Container(
          height: 12,
          alignment: AlignmentDirectional.centerStart,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(999),
          ),
          child: AnimatedFractionallySizedBox(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            widthFactor: progress,
            heightFactor: 1,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.all(Radius.circular(999)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
