import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';

class UserCardProfileButton extends StatelessWidget {
  const UserCardProfileButton({super.key, required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 38,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        iconAlignment: IconAlignment.end,
        icon: const Icon(LineIcons.arrowRight, size: 15),
        label: const Text('View profile'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.backgroundNormal,
          disabledBackgroundColor: AppColors.primary,
          disabledForegroundColor: AppColors.backgroundNormal,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
          textStyle: AppStyles.bold12,
        ),
      ),
    );
  }
}
