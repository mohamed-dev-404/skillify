import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';

class PublicProfileActions extends StatelessWidget {
  const PublicProfileActions({
    super.key,
    required this.onRequestSession,
    required this.onOfferSession,
  });

  final VoidCallback onRequestSession;
  final VoidCallback onOfferSession;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final shouldStack = constraints.maxWidth < 360;

        if (shouldStack) {
          return Column(
            children: [
              _ProfileActionButton(
                label: 'Request Session',
                icon: LineIcons.calendarCheck,
                onPressed: onRequestSession,
                isPrimary: true,
              ),
              const Gap(10),
              _ProfileActionButton(
                label: 'Offer Session',
                icon: LineIcons.handshake,
                onPressed: onOfferSession,
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(
              child: _ProfileActionButton(
                label: 'Request Session',
                icon: LineIcons.calendarCheck,
                onPressed: onRequestSession,
                isPrimary: true,
              ),
            ),
            const Gap(12),
            Expanded(
              child: _ProfileActionButton(
                label: 'Offer Session',
                icon: LineIcons.handshake,
                onPressed: onOfferSession,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ProfileActionButton extends StatelessWidget {
  const _ProfileActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.isPrimary = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = isPrimary
        ? AppColors.backgroundNormal
        : AppColors.primary;

    return SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 16),
        label: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        style: ElevatedButton.styleFrom(
          elevation: isPrimary ? 2 : 0,
          shadowColor: AppColors.primary.withValues(alpha: 0.18),
          backgroundColor: isPrimary
              ? AppColors.primary
              : AppColors.backgroundNormal,
          foregroundColor: foregroundColor,
          textStyle: AppStyles.bold14,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isPrimary ? AppColors.primary : AppColors.borderNormal,
            ),
          ),
        ),
      ),
    );
  }
}
