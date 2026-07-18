import 'package:flutter/material.dart';
import 'package:skillify/core/routes/navigations_helper.dart';
import 'package:skillify/core/routes/routes.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/features/sessions/join_session/models/call_view_params.dart';

class JoinSessionButton extends StatelessWidget {
  const JoinSessionButton({
    super.key,
    required this.params,
    this.label = 'Join Session',
    this.minWidth = double.infinity,
    this.minHeight = 48,
    this.borderRadius = 12,
    this.isCompact = false,
  });

  final CallViewParams params;
  final String label;
  final double minWidth;
  final double minHeight;
  final double borderRadius;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.successNormal.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.successNormal,
          foregroundColor: AppColors.backgroundNormal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          minimumSize: Size(minWidth, minHeight),
          maximumSize: Size(double.infinity, minHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0, // Handled by outer container shadow
        ),
        onPressed: () {
          push(context, Routes.callView, extra: params);
        },
        child: isCompact ? _buildCompactStyle() : _buildLargeStyle(),
      ),
    );
  }

  Widget _buildLargeStyle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.backgroundNormal.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.videocam_rounded,
            color: AppColors.backgroundNormal,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: AppStyles.bold16.copyWith(
            color: AppColors.backgroundNormal,
          ),
        ),
      ],
    );
  }

  Widget _buildCompactStyle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.videocam_rounded,
          color: AppColors.backgroundNormal,
          size: 18,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: AppStyles.bold14.copyWith(
            color: AppColors.backgroundNormal,
          ),
        ),
      ],
    );
  }
}

