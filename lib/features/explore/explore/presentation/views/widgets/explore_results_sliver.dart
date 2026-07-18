import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/routes/navigations_helper.dart';
import 'package:skillify/core/routes/routes.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/animated_loading_widget.dart';
import 'package:skillify/core/widgets/empty_state_widget.dart';
import 'package:skillify/features/explore/explore/presentation/view_model/explore_cubit/explore_cubit.dart';
import 'package:skillify/features/explore/explore/presentation/views/widgets/explore_user_card/explore_user_card.dart';

class ExploreResultsSliver extends StatelessWidget {
  const ExploreResultsSliver({
    super.key,
    required this.usersState,
    required this.onRetry,
  });

  final ExploreUsersState usersState;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (usersState.users.isNotEmpty) {
      return SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
        sliver: SliverList.separated(
          itemCount: usersState.users.length,
          itemBuilder: (context, index) {
            final user = usersState.users[index];

            return ExploreUserCard(
              data: user,
              onTap: () => push(context, Routes.publicProfile(user.userId)),
            );
          },
          separatorBuilder: (_, _) => const Gap(14),
        ),
      );
    }

    return SliverFillRemaining(
      hasScrollBody: false,
      child: switch (usersState.status) {
        ExploreUsersStatus.loading ||
        ExploreUsersStatus.initial => const AnimatedLoadingWidget(height: 110),
        ExploreUsersStatus.failure => _ExploreFailure(
          message: usersState.errorMessage,
          onRetry: onRetry,
        ),
        _ => const EmptyStateWidget(
          title: 'No matches found',
          subtitle: 'Try changing your search or filters to find more people.',
          lottieHeight: 170,
          padding: EdgeInsets.fromLTRB(24, 12, 24, 32),
        ),
      },
    );
  }
}

class _ExploreFailure extends StatelessWidget {
  const _ExploreFailure({required this.message, required this.onRetry});

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
              message ?? 'Could not load users',
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
