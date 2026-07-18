import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillify/features/explore/explore/presentation/view_model/explore_cubit/explore_cubit.dart';

class ExplorePaginatedScrollView extends StatefulWidget {
  const ExplorePaginatedScrollView({
    super.key,
    required this.slivers,
  });

  final List<Widget> slivers;

  @override
  State<ExplorePaginatedScrollView> createState() =>
      _ExplorePaginatedScrollViewState();
}

class _ExplorePaginatedScrollViewState
    extends State<ExplorePaginatedScrollView> {
  static const double _loadMoreThreshold = 300;

  final ScrollController _scrollController = ScrollController();

  ExploreCubit get _cubit => context.read<ExploreCubit>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreWhenNearBottom);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_loadMoreWhenNearBottom)
      ..dispose();
    super.dispose();
  }

  void _loadMoreWhenNearBottom() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;
    final isNearBottom =
        position.pixels >= position.maxScrollExtent - _loadMoreThreshold;

    if (isNearBottom) _cubit.loadMoreUsers();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _loadMoreWhenNearBottom();
    });

    return CustomScrollView(
      controller: _scrollController,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: widget.slivers,
    );
  }
}
