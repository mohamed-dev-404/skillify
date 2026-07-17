import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';

class SettingsLogoutTile extends StatelessWidget {
  const SettingsLogoutTile({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        splashColor: AppColors.errorNormal.withOpacity(0.16),
        highlightColor: AppColors.errorNormal.withOpacity(0.10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.backgroundLight.withOpacity(0.94),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.borderNormal,
              width: 1.1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.errorLight,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  color: AppColors.errorNormal,
                  size: 20,
                ),
              ),
              const Gap(12),
              Expanded(
                child: Text(
                  'Log out',
                  style: AppStyles.medium15.copyWith(
                    color: AppColors.textPrimaryNormal,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: AppColors.textSecondaryNormal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
