import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/assets/app_icons.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/custom_svg_picture.dart';

/// Bottom navigation of the complete profile flow: Back + Continue buttons.
class StepNavBar extends StatelessWidget {
  const StepNavBar({
    super.key,
    this.onBack,
    required this.onContinue,
    this.continueText = 'Continue',
    this.isLastStep = false,
    this.isLoading = false,
  });

  /// When null the Back button is hidden (first step).
  final VoidCallback? onBack;
  final VoidCallback onContinue;
  final String continueText;

  /// Shows a check icon on the continue button instead of the forward arrow.
  final bool isLastStep;

  /// When true both buttons are disabled and the continue button
  /// shows a spinner (used while submitting the profile).
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: onBack == null
          ? MainAxisAlignment.end
          : MainAxisAlignment.spaceBetween,
      children: [
        if (onBack != null)
          _NavButton(
            text: 'Back',
            bgColor: AppColors.secondary,
            iconPath: AppIcons.arrowLeftSvg,
            iconLeading: true,
            onPressed: isLoading ? null : onBack,
          ),
        _NavButton(
          text: continueText,
          bgColor: AppColors.primary,
          iconPath: isLastStep
              ? AppIcons.checkCircleSvg
              : AppIcons.arrowRightSvg,
          isLoading: isLoading,
          onPressed: isLoading ? null : onContinue,
        ),
      ],
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.text,
    required this.bgColor,
    required this.iconPath,
    required this.onPressed,
    this.iconLeading = false,
    this.isLoading = false,
  });

  final String text;
  final Color bgColor;
  final String iconPath;
  final VoidCallback? onPressed;
  final bool iconLeading;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final Widget icon = isLoading
        ? const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.backgroundNormal,
            ),
          )
        : CustomSvgPicture(
            path: iconPath,
            width: 18,
            height: 18,
            color: AppColors.backgroundNormal,
          );
    final label = Text(
      text,
      style: AppStyles.bold15.copyWith(color: AppColors.backgroundNormal),
    );

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        disabledBackgroundColor: bgColor,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: iconLeading
            ? [icon, const Gap(8), label]
            : [label, const Gap(8), icon],
      ),
    );
  }
}
