import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/buttons/main_button.dart';
import 'package:skillify/core/widgets/animated_loading_widget.dart';
import 'package:skillify/features/explore/data/models/explore_filters.dart';
import 'package:skillify/features/explore/explore/presentation/view_model/explore_cubit/explore_cubit.dart';
import 'package:skillify/features/explore/explore/presentation/views/widgets/explore_filter_dropdown.dart';

class ExploreFilterSheet extends StatefulWidget {
  const ExploreFilterSheet({
    super.key,
    required this.initialFilters,
  });

  final ExploreFilters initialFilters;

  @override
  State<ExploreFilterSheet> createState() => _ExploreFilterSheetState();
}

class _ExploreFilterSheetState extends State<ExploreFilterSheet> {
  int? _skillId;
  int? _languageId;
  double? _rating;

  int get _filterCount => [
    _skillId != null,
    _languageId != null,
    _rating != null,
  ].where((isActive) => isActive).length;

  @override
  void initState() {
    super.initState();
    _skillId = widget.initialFilters.skillId;
    _languageId = widget.initialFilters.langId;
    _rating = widget.initialFilters.minRating;
  }

  void _clear() {
    setState(() {
      _skillId = null;
      _languageId = null;
      _rating = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ExploreCubit>();
    final lookupsState = cubit.state.lookupsState;

    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        10,
        20,
        20 + MediaQuery.viewPaddingOf(context).bottom,
      ),
      decoration: const BoxDecoration(
        color: AppColors.backgroundNormal,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderNormal,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const Gap(20),
            Row(
              children: [
                Text('Filter results', style: AppStyles.bold20),
                const Spacer(),
                TextButton(
                  onPressed: _clear,
                  child: Text(
                    'Clear all',
                    style: AppStyles.bold14.copyWith(
                      color: AppColors.secondaryDark,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(6),
            Text(
              'Narrow the results to find your best match.',
              style: AppStyles.regular14.copyWith(
                color: AppColors.textSecondaryNormal,
              ),
            ),
            const Gap(22),
            if (lookupsState.status == ExploreLookupsStatus.loading ||
                lookupsState.status == ExploreLookupsStatus.initial)
              const AnimatedLoadingWidget(height: 70)
            else if (lookupsState.status == ExploreLookupsStatus.failure)
              _LookupsFailure(
                message: lookupsState.errorMessage ?? 'Could not load filters',
                onRetry: cubit.loadLookups,
              )
            else ...[
              ExploreFilterDropdown(
                label: 'Skill you want to learn',
                icon: LineIcons.graduationCap,
                hint: 'Select a skill',
                value: _skillId,
                items: lookupsState.skills
                    .map(
                      (skill) => ExploreFilterOption(
                        id: skill.id,
                        name: skill.name,
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _skillId = value),
              ),
              const Gap(16),
              ExploreFilterDropdown(
                label: 'Language',
                icon: LineIcons.language,
                hint: 'Select a language',
                value: _languageId,
                items: lookupsState.languages
                    .map(
                      (language) => ExploreFilterOption(
                        id: language.id,
                        name: language.name,
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _languageId = value),
              ),
            ],
            const Gap(20),
            Text('Minimum rating', style: AppStyles.bold14),
            const Gap(12),
            Wrap(
              spacing: 8,
              children: [0.0, 3.0, 4.0, 4.5]
                  .map(
                    (rating) => ChoiceChip(
                      showCheckmark: false,
                      selected: (_rating ?? 0) == rating,
                      onSelected: (_) =>
                          setState(() => _rating = rating == 0 ? null : rating),
                      side: BorderSide(
                        color: (_rating ?? 0) == rating
                            ? AppColors.primary
                            : AppColors.borderNormal,
                      ),
                      backgroundColor: AppColors.backgroundNormal,
                      selectedColor: AppColors.primaryLight,
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (rating > 0) ...[
                            const Icon(
                              Icons.star_rounded,
                              size: 15,
                              color: AppColors.warningNormal,
                            ),
                            const Gap(3),
                          ],
                          Text(
                            rating == 0 ? 'Any' : '$rating+',
                            style: AppStyles.medium12.copyWith(
                              color: (_rating ?? 0) == rating
                                  ? AppColors.primary
                                  : AppColors.textSecondaryNormal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
            const Gap(26),
            MainButton(
              text: _filterCount == 0
                  ? 'Show all results'
                  : 'Show results  ($_filterCount filters)',
              onPressed: () => Navigator.pop(
                context,
                widget.initialFilters.copyWith(
                  page: null,
                  skillId: _skillId,
                  langId: _languageId,
                  minRating: _rating,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LookupsFailure extends StatelessWidget {
  const _LookupsFailure({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.errorLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppStyles.regular12.copyWith(color: AppColors.errorDark),
          ),
          const Gap(8),
          TextButton(onPressed: onRetry, child: const Text('Try again')),
        ],
      ),
    );
  }
}
