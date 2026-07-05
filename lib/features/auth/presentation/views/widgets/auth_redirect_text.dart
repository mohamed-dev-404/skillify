import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';

/// Bottom prompt for auth views, e.g. "Don't have an account?  Register".
class AuthRedirectText extends StatelessWidget {
  const AuthRedirectText({
    super.key,
    required this.text,
    required this.actionText,
    required this.onTap,
  });

  final String text;
  final String actionText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: AppStyles.regular14.copyWith(
            color: AppColors.textSecondaryNormal,
          ),
        ),
        const Gap(6),
        TextButton(
          onPressed: onTap,
          child: Text(
            actionText,
            style: AppStyles.bold15.copyWith(color: AppColors.secondary),
          ),
        ),
      ],
    );
  }
}
