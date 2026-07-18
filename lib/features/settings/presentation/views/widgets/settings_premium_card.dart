import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';

class SettingsPremiumCard extends StatelessWidget {
  const SettingsPremiumCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.96),
            AppColors.secondary.withOpacity(0.92),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.borderLight,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.16),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  color: AppColors.backgroundLight,
                  size: 24,
                ),
              ),
              const Gap(12),
              Expanded(
                child: Text(
                  'Get Premium Subscription',
                  style: AppStyles.bold16.copyWith(
                    color: AppColors.backgroundLight,
                  ),
                ),
              ),
            ],
          ),
          const Gap(12),
          Text(
            'Unlock smarter tools, advanced matching, and more control over your experience.',
            style: AppStyles.regular14.copyWith(
              color: AppColors.backgroundLight.withOpacity(0.95),
              height: 1.5,
            ),
          ),
          const Gap(12),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight.withOpacity(0.16),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    'Buy Bucket of Credits',
                    style: AppStyles.medium14.copyWith(
                      color: AppColors.backgroundLight,
                    ),
                  ),
                ),
              ),
              const Gap(10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight.withOpacity(0.22),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.backgroundLight,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
