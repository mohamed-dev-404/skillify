import 'package:flutter/material.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/widgets/buttons/main_button.dart';
import 'package:skillify/features/sessions/reschedule_session/views/reschedule_session_bottom_sheet.dart';

class RescheduleSessionButton extends StatelessWidget {
  final int sessionId;
  final double minWidth;
  final double minHeight;

  const RescheduleSessionButton({
    super.key,
    required this.sessionId,
    this.minWidth = double.infinity,
    this.minHeight = 56,
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
        return RescheduleSessionBottomSheet(sessionId: sessionId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainButton(
      text: 'Reschedule',
      bgColor: AppColors.primary,
      minWidth: minWidth,
      minHeight: minHeight,
      onPressed: () => _openRescheduleSheet(context),
    );
  }
}
