import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/assets/app_images.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';

/// Shared header for auth views: app logo + title + subtitle.
class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          AppImages.logoPng,
          width: 230,
        ),
        const Gap(32),
        Text(title, style: AppStyles.bold32.copyWith(color: AppColors.primary)),
        const Gap(4),
        Text(
          subtitle,
          style: AppStyles.bold20.copyWith(color: AppColors.secondary),
        ),
      ],
    );
  }
}
