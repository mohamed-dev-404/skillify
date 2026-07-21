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
    this.minHeight = 42,
    this.borderRadius = 14,
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
      constraints: BoxConstraints(
        minWidth: minWidth,
        minHeight: minHeight,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF22C55E),
            Color(0xFF16A34A),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.successNormal.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: AppColors.successNormal.withValues(alpha: 0.15),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            push(context, Routes.callView, extra: params);
          },
          borderRadius: BorderRadius.circular(borderRadius),
          splashColor: Colors.white.withValues(alpha: 0.2),
          highlightColor: Colors.white.withValues(alpha: 0.1),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isCompact ? 12 : 20,
              vertical: isCompact ? 10 : 14,
            ),
            child: isCompact ? _buildCompactStyle() : _buildLargeStyle(),
          ),
        ),
      ),
    );
  }

  Widget _buildLargeStyle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.videocam_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: AppStyles.bold16.copyWith(
            color: Colors.white,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(width: 8),
        Icon(
          Icons.arrow_forward_rounded,
          color: Colors.white.withValues(alpha: 0.7),
          size: 18,
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
          color: Colors.white,
          size: 18,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: AppStyles.bold14.copyWith(
            color: Colors.white,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
