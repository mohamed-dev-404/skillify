import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/features/explore/data/explore_demo_data.dart';
import 'package:skillify/features/explore/presentation/views/widgets/explore_filter_sheet.dart';
import 'package:skillify/features/explore/presentation/views/widgets/explore_header.dart';
import 'package:skillify/features/explore/presentation/views/widgets/explore_results_header.dart';
import 'package:skillify/features/explore/presentation/views/widgets/explore_search_bar.dart';
import 'package:skillify/features/explore/presentation/views/widgets/explore_user_card/explore_user_card.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  final TextEditingController _searchController = TextEditingController();
  int _activeFilters = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openFilters() async {
    final count = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ExploreFilterSheet(initialFilterCount: _activeFilters),
    );

    if (count != null && mounted) {
      setState(() => _activeFilters = count);
    }
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const users = ExploreDemoData.users;

    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                sliver: SliverList.list(
                  children: [
                    const ExploreHeader(),
                    const Gap(22),
                    ExploreSearchBar(
                      controller: _searchController,
                      activeFilters: _activeFilters,
                      onFilterTap: _openFilters,
                      onChanged: (_) => setState(() {}),
                      onClear: _clearSearch,
                    ),
                    const Gap(24),
                    ExploreResultsHeader(resultsCount: users.length),
                    const Gap(16),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                sliver: SliverList.separated(
                  itemCount: users.length,
                  itemBuilder: (_, index) => ExploreUserCard(
                    data: users[index],
                  ),
                  separatorBuilder: (_, _) => const Gap(14),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
