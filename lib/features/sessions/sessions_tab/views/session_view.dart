import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/animated_loading_widget.dart';
import 'package:skillify/core/widgets/empty_state_widget.dart';
import 'package:skillify/features/sessions/sessions_tab/view_model/sessions_cubit/sessions_cubit.dart';
import 'package:skillify/features/sessions/sessions_tab/view_model/sessions_cubit/sessions_state.dart';
import 'package:skillify/features/sessions/sessions_tab/views/widgets/session_card.dart';
import 'package:skillify/features/sessions/sessions_tab/views/widgets/session_error_widget.dart';

class SessionsView extends StatefulWidget {
  const SessionsView({super.key});

  @override
  State<SessionsView> createState() => _SessionsViewState();
}

class _SessionsViewState extends State<SessionsView>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChange() {
    if (_tabController.indexIsChanging) {
      context.read<SessionsCubit>().getSessions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Premium Segmented Tab Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: ListenableBuilder(
            listenable: _tabController,
            builder: (context, _) {
              return Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    _buildPillTab(
                      icon: Icons.help_outline_rounded,
                      label: 'Need Help',
                      isSelected: _tabController.index == 0,
                      onTap: () => _tabController.animateTo(0),
                    ),
                    _buildPillTab(
                      icon: Icons.volunteer_activism_outlined,
                      label: 'Offer Help',
                      isSelected: _tabController.index == 1,
                      onTap: () => _tabController.animateTo(1),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        // Tab Views
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildSessionsTab(isRequested: true),
              _buildSessionsTab(isRequested: false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPillTab({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected
                    ? AppColors.backgroundNormal
                    : AppColors.textSecondaryNormal,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: (isSelected ? AppStyles.bold14 : AppStyles.medium14)
                    .copyWith(
                      color: isSelected
                          ? AppColors.backgroundNormal
                          : AppColors.textSecondaryNormal,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSessionsTab({required bool isRequested}) {
    return BlocBuilder<SessionsCubit, SessionsState>(
      builder: (context, state) {
        final cubit = context.read<SessionsCubit>();

        if (isRequested) {
          // Need Help Tab (Requested Sessions)
          if (state is RequestedSessionsFailure) {
            return SessionErrorWidget(
              errorMessage: state.errorMessage,
              onRetry: () => cubit.getSessions(),
            );
          }

          if (state is RequestedSessionsSuccess) {
            if (state.isEmpty) {
              return const EmptyStateWidget(
                title: 'No Help Requests',
                subtitle:
                    'You haven\'t requested help yet.\nExplore available tutors!',
              );
            }
            return _buildSessionsList(cubit.requestedSessions, cubit);
          }

          // While loading, show loading only if we don't have previous data
          if (state is SessionsLoading && cubit.requestedSessions.isEmpty) {
            return const AnimatedLoadingWidget();
          }

          // If we have previous data while new request is loading, show the data
          if (cubit.requestedSessions.isNotEmpty) {
            return _buildSessionsList(cubit.requestedSessions, cubit);
          }
        } else {
          // Offer Help Tab (Received Sessions)
          if (state is ReceivedSessionsFailure) {
            return SessionErrorWidget(
              errorMessage: state.errorMessage,
              onRetry: () => cubit.getSessions(),
            );
          }

          if (state is ReceivedSessionsSuccess) {
            if (state.isEmpty) {
              return const EmptyStateWidget(
                title: 'No Help Offers',
                subtitle:
                    'You haven\'t received any help requests yet.\nWhen someone requests your help, it will appear here!',
              );
            }
            return _buildSessionsList(cubit.receivedSessions, cubit);
          }

          // While loading, show loading only if we don't have previous data
          if (state is SessionsLoading && cubit.receivedSessions.isEmpty) {
            return const AnimatedLoadingWidget();
          }

          // If we have previous data while new request is loading, show the data
          if (cubit.receivedSessions.isNotEmpty) {
            return _buildSessionsList(cubit.receivedSessions, cubit);
          }
        }

        // Fallback loading state
        return const AnimatedLoadingWidget();
      },
    );
  }

  Widget _buildSessionsList(List sessions, SessionsCubit cubit) {
    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: AppColors.backgroundNormal,
      strokeWidth: 3,
      onRefresh: () async {
        cubit.getSessions();
      },
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        itemCount: sessions.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return SessionCard(
            session: sessions[index],
            onSuccess: () => context.read<SessionsCubit>().getSessions(),
          );
        },
      ),
    );
  }
}
