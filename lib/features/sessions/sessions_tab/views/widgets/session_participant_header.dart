import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/features/sessions/data/models/session_model.dart';
import 'package:skillify/features/sessions/sessions_tab/views/widgets/session_status_badge.dart';
import 'package:skillify/features/sessions/sessions_tab/views/widgets/session_ui_helper.dart';

class SessionParticipantHeader extends StatelessWidget {
  const SessionParticipantHeader({
    super.key,
    required this.session,
    this.isLarge = false,
  });

  final SessionModel session;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    final name = session.otherParticipantName;
    final initials = session.otherParticipantInitials;
    final color = session.avatarColor;
    final badgeConfig = StatusBadgeConfig.from(session.sessionStatus);

    return Row(
      children: [
        // Avatar
        Container(
          width: isLarge ? 56 : 44,
          height: isLarge ? 56 : 44,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              initials,
              style: (isLarge ? AppStyles.bold20 : AppStyles.bold16).copyWith(
                color: color,
              ),
            ),
          ),
        ),
        Gap(isLarge ? 16 : 12),

        // Name + Skill
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      name.isNotEmpty ? name : 'Unknown',
                      style: isLarge ? AppStyles.medium16 : AppStyles.medium14,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isLarge) ...[
                    const Gap(8),
                    _buildTypeLabel(),
                  ],
                ],
              ),
              if (session.mainSkillName.isNotEmpty) ...[
                const Gap(2),
                Text(
                  session.mainSkillName,
                  style: (isLarge ? AppStyles.regular14 : AppStyles.regular12)
                      .copyWith(color: AppColors.textSecondaryNormal),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
        if (!isLarge) const Gap(8),

        // Status badge
        if (!isLarge) SessionStatusBadge(config: badgeConfig),
      ],
    );
  }

  Widget _buildTypeLabel() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        session.isRequested ? 'Requested' : 'Received',
        style: AppStyles.medium12.copyWith(color: AppColors.primaryDark),
      ),
    );
  }
}
