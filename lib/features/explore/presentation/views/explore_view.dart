import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:skillify/features/explore/presentation/view_model/explore_cubit/explore_cubit.dart';
import 'package:skillify/features/explore/presentation/views/widgets/explore_header.dart';
import 'package:skillify/features/explore/presentation/views/widgets/explore_paginated_scroll_view.dart';
import 'package:skillify/features/explore/presentation/views/widgets/explore_pagination_footer.dart';
import 'package:skillify/features/explore/presentation/views/widgets/explore_presentation_extensions.dart';
import 'package:skillify/features/explore/presentation/views/widgets/explore_results_header.dart';
import 'package:skillify/features/explore/presentation/views/widgets/explore_results_sliver.dart';
import 'package:skillify/features/explore/presentation/views/widgets/explore_search_section.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreState>(
      builder: (context, state) {
        final usersState = state.usersState;

        return Column(
          children: [
            Expanded(
              child: ExplorePaginatedScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    sliver: SliverList.list(
                      children: [
                        const ExploreHeader(),
                        const Gap(22),
                        ExploreSearchSection(
                          filters: usersState.filters,
                        ),
                        const Gap(24),
                        ExploreResultsHeader(
                          resultsCount: usersState.totalCount,
                        ),
                        if (usersState.isRefreshing) ...[
                          const Gap(10),
                          const LinearProgressIndicator(minHeight: 2),
                        ],
                        const Gap(16),
                      ],
                    ),
                  ),
                  ExploreResultsSliver(
                    usersState: usersState,
                    onRetry: context.read<ExploreCubit>().getUsers,
                  ),
                  ExplorePaginationFooter(
                    isLoading: usersState.isLoadingMore,
                    errorMessage: usersState.loadMoreError,
                    onRetry: () =>
                        context.read<ExploreCubit>().loadMoreUsers(retry: true),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
