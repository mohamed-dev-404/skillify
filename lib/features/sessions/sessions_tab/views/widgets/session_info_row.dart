import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';

class SessionInfoRow extends StatelessWidget {
  const SessionInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.valueColor,
  });

  final String label;
  final String value;
  final IconData? icon;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    if (value.trim().isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 18,
              color: AppColors.textSecondaryNormal.withValues(alpha: 0.8),
            ),
            const Gap(12),
          ] else ...[
            const Gap(30), // Indent if no icon to match rows with icons
          ],
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: AppStyles.regular14.copyWith(
                color: AppColors.textSecondaryNormal,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: AppStyles.medium14.copyWith(
                color: valueColor ?? AppColors.textPrimaryNormal,
                height: 1.4,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
