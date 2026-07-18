import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/animated_loading_widget.dart';
import 'package:skillify/core/widgets/app_scaffold.dart';
import 'package:skillify/core/widgets/empty_state_widget.dart';
import 'package:skillify/features/notification/presentation/view_model/notification_cubit/notification_cubit.dart';
import 'package:skillify/features/notification/presentation/views/widgets/notification_item_tile.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.textPrimaryNormal,
          ),
        ),
        title: Text(
          'Notifications',
          style: AppStyles.bold20.copyWith(color: AppColors.textPrimaryNormal),
        ),
        centerTitle: false,
        actions: [
          BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
              if (state.status != NotificationStatus.success ||
                  state.unreadCount == 0) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.warningLight,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      '${state.unreadCount} new',
                      style: AppStyles.medium12.copyWith(
                        color: AppColors.warningDark,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            return switch (state.status) {
              NotificationStatus.loading ||
              NotificationStatus.initial => const AnimatedLoadingWidget(
                height: 110,
              ),
              NotificationStatus.failure => _NotificationsFailure(
                message: state.errorMessage,
                onRetry: context.read<NotificationCubit>().fetchNotifications,
              ),
              NotificationStatus.success => _NotificationsContent(state: state),
            };
          },
        ),
      ),
    );
  }
}

class _NotificationsContent extends StatelessWidget {
  const _NotificationsContent({required this.state});

  final NotificationState state;

  @override
  Widget build(BuildContext context) {
    if (state.notifications.isEmpty) {
      return const EmptyStateWidget(
        title: 'No notifications yet',
        subtitle: 'We will let you know when something new arrives.',
        lottieHeight: 200,
      );
    }

    return RefreshIndicator(
      onRefresh: context.read<NotificationCubit>().fetchNotifications,
      color: AppColors.primary,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        itemCount: state.notifications.length,
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemBuilder: (_, index) =>
            NotificationItemTile(notification: state.notifications[index]),
      ),
    );
  }
}

class _NotificationsFailure extends StatelessWidget {
  const _NotificationsFailure({required this.message, required this.onRetry});

  final String? message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: AppColors.errorNormal,
              size: 42,
            ),
            const Gap(12),
            Text(
              message ?? 'Could not load notifications',
              textAlign: TextAlign.center,
              style: AppStyles.regular14.copyWith(
                color: AppColors.textSecondaryNormal,
              ),
            ),
            const Gap(14),
            TextButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}
