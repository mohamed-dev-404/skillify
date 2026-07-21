import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:skillify/core/di/service_locator.dart';
import 'package:skillify/core/routes/routes.dart';
import 'package:skillify/core/utils/assets/app_images.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/features/notification/presentation/view_model/notification_cubit/notification_cubit.dart';

class ExploreHeader extends StatelessWidget {
  const ExploreHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AppImages.logoPng,
                width: 160,
              ),
              const Gap(8),
              Text(
                ' Find the right skill partner for you',
                style: AppStyles.regular14.copyWith(
                  color: AppColors.textSecondaryNormal,
                ),
              ),
            ],
          ),
        ),
        const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _NotificationBell(),
          ],
        ),
      ],
    );
  }
}

class _NotificationBell extends StatelessWidget {
  const _NotificationBell();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NotificationCubit>()..fetchUnreadCount(),
      child: BlocBuilder<NotificationCubit, NotificationState>(
        buildWhen: (previous, current) =>
            previous.unreadCount != current.unreadCount,
        builder: (context, state) {
          return HeaderActionButton(
            icon: Icons.notifications_active_rounded,
            iconColor: AppColors.warningNormal,
            hasBadge: state.unreadCount > 0,
            onTap: () => context.push(Routes.notifications),
          );
        },
      ),
    );
  }
}

class HeaderActionButton extends StatelessWidget {
  const HeaderActionButton({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.onTap,
    this.hasBadge = false,
  });

  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;
  final bool hasBadge;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.backgroundLight,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.borderNormal,
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 23,
                ),
              ),
              if (hasBadge)
                const Positioned(
                  top: 11,
                  right: 11,
                  child: CircleAvatar(
                    radius: 4,
                    backgroundColor: AppColors.errorNormal,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
