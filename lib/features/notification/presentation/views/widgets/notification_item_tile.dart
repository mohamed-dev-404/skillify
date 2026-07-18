import 'package:flutter/material.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/features/notification/data/models/notification_model.dart';

class NotificationItemTile extends StatelessWidget {
  const NotificationItemTile({super.key, required this.notification});

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    final isRead = notification.isRead;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isRead
            ? AppColors.backgroundLight
            : AppColors.warningLight.withValues(alpha: 0.34),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isRead
              ? AppColors.borderNormal
              : AppColors.warningLightActive,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isRead
                  ? AppColors.primaryLight
                  : AppColors.warningNormal.withValues(alpha: 0.16),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isRead
                  ? Icons.notifications_none_rounded
                  : Icons.notifications_active_rounded,
              color: isRead ? AppColors.primary : AppColors.warningNormal,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: AppStyles.bold14.copyWith(
                          color: AppColors.textPrimaryNormal,
                        ),
                      ),
                    ),
                    if (!isRead)
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(left: 6),
                        decoration: const BoxDecoration(
                          color: AppColors.warningNormal,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  notification.message,
                  style: AppStyles.regular12.copyWith(
                    color: AppColors.textSecondaryNormal,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _formatDate(notification.createdAt),
                  style: AppStyles.medium12.copyWith(
                    color: AppColors.textSecondaryNormal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? createdAt) {
    if (createdAt == null) return '';
    final date = createdAt.toLocal();
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$day/$month/$year • $hour:$minute';
  }
}
