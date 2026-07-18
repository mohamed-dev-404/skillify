import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/routes/navigations_helper.dart';
import 'package:skillify/core/routes/routes.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/features/sessions/data/models/session_model.dart';
import 'package:skillify/features/sessions/sessions_tab/views/widgets/session_actions_section.dart';
import 'package:skillify/features/sessions/sessions_tab/views/widgets/session_hint_card.dart';
import 'package:skillify/features/sessions/sessions_tab/views/widgets/session_info_chip.dart';
import 'package:skillify/features/sessions/sessions_tab/views/widgets/session_participant_header.dart';
import 'package:skillify/features/sessions/sessions_tab/views/widgets/session_rating_indicator.dart';
import 'package:skillify/features/sessions/sessions_tab/views/widgets/session_ui_helper.dart';

class SessionCard extends StatelessWidget {
  const SessionCard({super.key, required this.session});

  final SessionModel session;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        push(context, Routes.sessionDetails, extra: session);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundNormal,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderNormal, width: 1),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryDarker.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Avatar + Name + Badge
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: SessionParticipantHeader(session: session),
            ),

            // Topic (if available)
            if (session.topic.isNotEmpty) ...[
              const _CardDivider(),
              _buildTopic(),
            ],

            // Info row: duration, credits, timestamp
            const _CardDivider(),
            _buildInfoSection(),

            // Accepted hint / Rating indicator / etc.
            if (session.sessionStatus == SessionStatus.accepted) ...[
              const _CardDivider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SessionHintCard(session: session),
              ),
            ] else if (session.sessionStatus == SessionStatus.completed) ...[
              if (session.userRated) ...[
                const _CardDivider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: SessionRatingIndicator(score: session.userRatingScore.toDouble()),
                ),
              ] else if (session.userCanRate) ...[
                const _CardDivider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: RateSessionPlaceholder(sessionId: session.id),
                ),
              ]
            ],

            // Actions
            if (session.hasActions && session.sessionStatus != SessionStatus.accepted) ...[
              const _CardDivider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: SessionActionsSection(session: session),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTopic() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.subject_rounded,
            size: 16,
            color: AppColors.textSecondaryNormal.withValues(alpha: 0.6),
          ),
          const Gap(8),
          Expanded(
            child: Text(
              session.topic,
              style: AppStyles.regular14.copyWith(
                color: AppColors.textSecondaryNormal,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Wrap(
        spacing: 16,
        runSpacing: 8,
        children: [
          SessionInfoChip(
            icon: Icons.timer_outlined,
            label: '${session.durationMinutes} min',
          ),
          SessionInfoChip(
            icon: Icons.toll_rounded,
            label: '${session.creditCost} credits',
          ),
          SessionInfoChip(
            icon: Icons.calendar_today_outlined,
            label: '${session.relevantTimestampLabel} · ${session.relevantTimestamp}',
          ),
        ],
      ),
    );
  }
}

class _CardDivider extends StatelessWidget {
  const _CardDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: 1,
      color: AppColors.borderNormal,
    );
  }
}
