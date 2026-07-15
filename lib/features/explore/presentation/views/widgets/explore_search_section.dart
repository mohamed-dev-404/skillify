import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillify/core/common/debouncer.dart';
import 'package:skillify/features/explore/data/models/explore_filters.dart';
import 'package:skillify/features/explore/presentation/view_model/explore_cubit/explore_cubit.dart';
import 'package:skillify/features/explore/presentation/views/widgets/explore_filter_sheet.dart';
import 'package:skillify/features/explore/presentation/views/widgets/explore_presentation_extensions.dart';
import 'package:skillify/features/explore/presentation/views/widgets/explore_search_bar.dart';

class ExploreSearchSection extends StatefulWidget {
  const ExploreSearchSection({
    super.key,
    required this.filters,
  });

  final ExploreFilters filters;

  @override
  State<ExploreSearchSection> createState() => _ExploreSearchSectionState();
}

class _ExploreSearchSectionState extends State<ExploreSearchSection> {
  static const Duration _searchDelay = Duration(milliseconds: 500);

  final TextEditingController _searchController = TextEditingController();
  final Debouncer _searchDebouncer = Debouncer(
    milliseconds: _searchDelay.inMilliseconds,
  );

  ExploreCubit get _cubit => context.read<ExploreCubit>();

  @override
  void dispose() {
    _searchDebouncer.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openFilters() async {
    final cubit = _cubit;
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

  void _submitSearch(String value) {
    final searchName = value.trim();
    final currentName = _cubit.state.usersState.filters.name?.trim() ?? '';
    if (searchName == currentName) return;

    _cubit.applyFilters(
      _cubit.state.usersState.filters.copyWith(
        page: null,
        name: searchName.isEmpty ? null : searchName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExploreSearchBar(
      controller: _searchController,
      activeFilters: widget.filters.activeCount,
      onFilterTap: _openFilters,
      onChanged: _onSearchChanged,
      onSubmitted: _onSearchSubmitted,
      onClear: _clearSearch,
    );
  }
}
