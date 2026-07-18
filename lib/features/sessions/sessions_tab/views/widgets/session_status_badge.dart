import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/features/sessions/sessions_tab/views/widgets/session_ui_helper.dart';

class SessionStatusBadge extends StatelessWidget {
  const SessionStatusBadge({
    super.key,
    required this.config,
  });

  final StatusBadgeConfig config;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: config.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(config.icon, size: 13, color: config.foregroundColor),
          const Gap(4),
          Text(
            config.label,
            style: AppStyles.medium12.copyWith(
              color: config.foregroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
