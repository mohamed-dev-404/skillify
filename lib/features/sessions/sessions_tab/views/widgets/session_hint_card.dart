import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/features/sessions/data/models/session_model.dart';
import 'package:skillify/features/sessions/sessions_tab/views/widgets/session_ui_helper.dart';

class SessionHintCard extends StatelessWidget {
  const SessionHintCard({
    super.key,
    required this.session,
  });

  final SessionModel session;

  @override
  Widget build(BuildContext context) {
    final hint = SessionStatusHint.getHint(session);

    // Provide a subtle colored background based on status
    Color bgColor = AppColors.accentLight.withValues(alpha: 0.5);
    Color iconColor = AppColors.accentDark;

    switch (session.sessionStatus) {
      case SessionStatus.accepted:
        bgColor = AppColors.accent.withValues(alpha: 0.08);
        iconColor = AppColors.accentDark;
        break;
      case SessionStatus.active:
      case SessionStatus.completed:
        bgColor = AppColors.successLight.withValues(alpha: 0.5);
        iconColor = AppColors.successNormal;
        break;
      case SessionStatus.pending:
      case SessionStatus.reOffered:
        bgColor = AppColors.warningLight.withValues(alpha: 0.5);
        iconColor = AppColors.warningNormal;
        break;
      case SessionStatus.cancelled:
      case SessionStatus.declined:
        bgColor = AppColors.errorLight.withValues(alpha: 0.5);
        iconColor = AppColors.errorNormal;
        break;
      case SessionStatus.expired:
        bgColor = AppColors.textSecondaryLightActive.withValues(alpha: 0.2);
        iconColor = AppColors.textSecondaryNormal;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: iconColor.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 20,
            color: iconColor,
          ),
          const Gap(12),
          Expanded(
            child: Text(
              hint,
              style: AppStyles.regular14.copyWith(
                color: AppColors.textPrimaryNormal,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
