import 'package:flutter/material.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/features/sessions/reschedule_session/views/reschedule_session_bottom_sheet.dart';
import 'package:skillify/features/sessions/sessions_tab/views/widgets/session_action_button.dart';

class RescheduleSessionButton extends StatelessWidget {
  final int sessionId;
  final double minWidth;
  final double minHeight;
  final VoidCallback? onSuccess;

  const RescheduleSessionButton({
    super.key,
    required this.sessionId,
    this.minWidth = double.infinity,
    this.minHeight = 56,
    this.onSuccess,
  });

  void _openRescheduleSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundNormal,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return RescheduleSessionBottomSheet(
          sessionId: sessionId,
          onSuccess: onSuccess,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SessionActionButton(
      label: 'Reschedule',
      icon: Icons.schedule_rounded,
      color: AppColors.primary,
      minWidth: minWidth,
      minHeight: minHeight,
      style: SessionActionButtonStyle.outlined,
      onPressed: () => _openRescheduleSheet(context),
    );
  }
}
