import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/common/debouncer.dart';
import 'package:skillify/core/di/service_locator.dart';
import 'package:skillify/features/explore/data/models/explore_filters.dart';
import 'package:skillify/features/explore/presentation/view_model/explore_cubit/explore_cubit.dart';
import 'package:skillify/features/explore/presentation/views/widgets/explore_filter_sheet.dart';
import 'package:skillify/features/explore/presentation/views/widgets/explore_header.dart';
import 'package:skillify/features/explore/presentation/views/widgets/explore_pagination_footer.dart';
import 'package:skillify/features/explore/presentation/views/widgets/explore_results_header.dart';
import 'package:skillify/features/explore/presentation/views/widgets/explore_results_sliver.dart';
import 'package:skillify/features/explore/presentation/views/widgets/explore_search_bar.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ExploreCubit>()..initialize(),
      child: const _ExploreViewBody(),
    );
  }
}

class _ExploreViewBody extends StatefulWidget {
  const _ExploreViewBody();

  @override
  State<_ExploreViewBody> createState() => _ExploreViewBodyState();
}

class _ExploreViewBodyState extends State<_ExploreViewBody> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final Debouncer _searchDebouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchDebouncer.dispose();
    _searchController.dispose();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    const loadMoreThreshold = 300.0;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - loadMoreThreshold) {
      context.read<ExploreCubit>().loadMoreUsers();
    }
  }

  Future<void> _openFilters() async {
    final cubit = context.read<ExploreCubit>();
    final filters = await showModalBottomSheet<ExploreFilters>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: ExploreFilterSheet(
          initialFilters: cubit.state.usersState.filters,
        ),
      ),
    );

    if (filters != null && mounted) {
      await cubit.applyFilters(filters);
    }
  }

  void _submitSearch(String value) {
    final cubit = context.read<ExploreCubit>();
    final searchName = value.trim();
    final currentName = cubit.state.usersState.filters.name?.trim() ?? '';
    if (searchName == currentName) return;

    cubit.applyFilters(
      cubit.state.usersState.filters.copyWith(
        page: null,
        name: searchName.isEmpty ? null : searchName,
      ),
    );
  }

  void _onSearchChanged(String value) {
    setState(() {});
    _searchDebouncer.run(() {
      if (mounted) _submitSearch(value);
    });
  }

  void _onSearchSubmitted(String value) {
    _searchDebouncer.dispose();
    _submitSearch(value);
  }

  void _clearSearch() {
    _searchDebouncer.dispose();
    _searchController.clear();
    setState(() {});
    _submitSearch('');
  }

  int _activeFilterCount(ExploreFilters filters) {
    return [
      filters.skillId,
      filters.langId,
      filters.minRating,
    ].where((value) => value != null).length;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreState>(
      builder: (context, state) {
        final usersState = state.usersState;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _onScroll();
        });

        return Column(
          children: [
            Expanded(
              child: CustomScrollView(
                controller: _scrollController,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    sliver: SliverList.list(
                      children: [
                        const ExploreHeader(),
                        const Gap(22),
                        ExploreSearchBar(
                          controller: _searchController,
                          activeFilters: _activeFilterCount(
                            usersState.filters,
                          ),
                          onFilterTap: _openFilters,
                          onChanged: _onSearchChanged,
                          onSubmitted: _onSearchSubmitted,
                          onClear: _clearSearch,
                        ),
                        const Gap(24),
                        ExploreResultsHeader(
                          resultsCount: usersState.totalCount,
                        ),
                        if (usersState.status == ExploreUsersStatus.loading &&
                            usersState.users.isNotEmpty) ...[
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
                    onRetry: () => context.read<ExploreCubit>().loadMoreUsers(
                      retry: true,
                    ),
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
