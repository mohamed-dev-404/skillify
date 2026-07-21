import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/routes/navigations_helper.dart';
import 'package:skillify/core/utils/assets/app_icons.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/app_scaffold.dart';
import 'package:skillify/core/widgets/custom_svg_picture.dart';
import 'package:skillify/features/sessions/data/models/session_model.dart';
import 'package:skillify/features/sessions/sessions_tab/views/widgets/session_actions_section.dart';
import 'package:skillify/features/sessions/sessions_tab/views/widgets/session_hint_card.dart';
import 'package:skillify/features/sessions/sessions_tab/views/widgets/session_info_row.dart';
import 'package:skillify/features/sessions/sessions_tab/views/widgets/session_participant_header.dart';
import 'package:skillify/features/sessions/sessions_tab/views/widgets/session_rating_indicator.dart';
import 'package:skillify/features/sessions/sessions_tab/views/widgets/session_ui_helper.dart';

class SessionDetailsView extends StatelessWidget {
  const SessionDetailsView({
    super.key,
    required this.session,
  });

  final SessionModel session;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text('Session Details', style: AppStyles.bold20),
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.textPrimaryNormal),
        leading: IconButton(
          onPressed: () => pop(context),
          icon: const CustomSvgPicture(path: AppIcons.arrowLeftSvg),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Participant Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SessionParticipantHeader(
                  session: session,
                  isLarge: true, // Use the large version for details screen
                ),
              ),

              const Divider(
                height: 1,
                thickness: 1,
                color: AppColors.borderNormal,
              ),

              // Hint Card (displays helpful text based on state)
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SessionHintCard(session: session),
              ),

              // Full Problem Description (if available)
              if (session.problemDescription.isNotEmpty ||
                  session.topic.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'Topic & Description',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryNormal,
                    ),
                  ),
                ),
                const Gap(12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundNormal,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.borderNormal),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (session.topic.isNotEmpty) ...[
                          Text(
                            session.topic,
                            style: AppStyles.medium16.copyWith(
                              color: AppColors.textPrimaryNormal,
                            ),
                          ),
                          if (session.problemDescription.isNotEmpty)
                            const Gap(8),
                        ],
                        if (session.problemDescription.isNotEmpty)
                          Text(
                            session.problemDescription,
                            style: AppStyles.regular14.copyWith(
                              color: AppColors.textSecondaryNormal,
                              height: 1.5,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const Gap(24),
              ],

              // Session Information Rows
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Session Information',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimaryNormal,
                      ),
                    ),
                    const Gap(16),
                    SessionInfoRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'Scheduled Date',
                      value: session.scheduledAtText,
                    ),
                    SessionInfoRow(
                      icon: Icons.timer_outlined,
                      label: 'Duration',
                      value: '${session.durationMinutes} Minutes',
                    ),
                    SessionInfoRow(
                      icon: Icons.toll_rounded,
                      label: 'Cost',
                      value: '${session.creditCost} Credits',
                    ),
                    SessionInfoRow(
                      icon: Icons.category_outlined,
                      label: 'Skill Category',
                      value: session.mainSkillName,
                    ),
                  ],
                ),
              ),

              const Gap(16),
              const Divider(
                height: 1,
                thickness: 1,
                color: AppColors.borderNormal,
              ),
              const Gap(24),

              // Timeline/History Rows
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'History',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimaryNormal,
                      ),
                    ),
                    const Gap(16),
                    SessionInfoRow(
                      icon: Icons.history_rounded,
                      label: 'Created At',
                      value: session.createdAtText,
                    ),
                    if (session.acceptedAt != null)
                      SessionInfoRow(
                        icon: Icons.check_circle_outline_rounded,
                        label: 'Accepted At',
                        value: session.acceptedAtText,
                      ),
                    if (session.completedAt != null)
                      SessionInfoRow(
                        icon: Icons.done_all_rounded,
                        label: 'Completed At',
                        value: session.completedAtText,
                      ),
                  ],
                ),
              ),

              // Rating section (only if completed)
              if (session.sessionStatus == SessionStatus.completed) ...[
                const Gap(24),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColors.borderNormal,
                ),
                const Gap(24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Feedback',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimaryNormal,
                        ),
                      ),
                      const Gap(16),
                      if (session.userRated)
                        SessionRatingIndicator(
                          score: session.userRatingScore.toDouble(),
                        )
                      else if (session.userCanRate)
                        RateSessionPlaceholder(sessionId: session.id)
                      else
                        Text(
                          'Rating not available',
                          style: AppStyles.regular14.copyWith(
                            color: AppColors.textSecondaryNormal,
                          ),
                        ),
                    ],
                  ),
                ),
              ],

              const Gap(48),
            ],
          ),
        ),
      ),
      bottomNavigationBar: session.hasActions
          ? Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.textPrimaryNormal.withValues(alpha: 0.05),
                    offset: const Offset(0, -4),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: SafeArea(
                child: SessionActionsSection(
                  session: session,
                  shouldBack:
                      true, // Actions from details page pop back on success
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
