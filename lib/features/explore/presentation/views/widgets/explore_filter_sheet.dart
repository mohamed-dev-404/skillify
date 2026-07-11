import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/buttons/main_button.dart';
import 'package:skillify/features/explore/presentation/views/widgets/explore_filter_dropdown.dart';

class ExploreFilterSheet extends StatefulWidget {
  const ExploreFilterSheet({super.key, this.initialFilterCount = 0});

  final int initialFilterCount;

  @override
  State<ExploreFilterSheet> createState() => _ExploreFilterSheetState();
}

class _ExploreFilterSheetState extends State<ExploreFilterSheet> {
  String? _skill;
  String? _language;
  double _rating = 0;

  int get _filterCount =>
      [_skill != null, _language != null, _rating > 0].where((e) => e).length;

  void _clear() {
    setState(() {
      _skill = null;
      _language = null;
      _rating = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            ExploreFilterDropdown(
              label: 'Skill you want to learn',
              icon: LineIcons.graduationCap,
              hint: 'Select a skill',
              value: _skill,
              items: const [
                'Programming',
                'Flutter',
                'DevOps',
                'UI/UX Design',
                'Programmings',
                'Flutters',
                'DevOpss',
                'UI/UX Dessign',
                'Programmisng',
                'Fluttaser',
                'DevOpdsas',
                'UI/UX Deasdsign',
                'Programminqwwqg',
                'Flutterads',
                'DevOpssda',
                'UI/UX Dessadign',
              ],
              onChanged: (value) => setState(() => _skill = value),
            ),
            const Gap(16),
            ExploreFilterDropdown(
              label: 'Language',
              icon: LineIcons.language,
              hint: 'Select a language',
              value: _language,
              items: const ['Arabic', 'English', 'French'],
              onChanged: (value) => setState(() => _language = value),
            ),
            const Gap(20),
            Text('Minimum rating', style: AppStyles.bold14),
            const Gap(12),
            Wrap(
              spacing: 8,
              children: [0.0, 3.0, 4.0, 4.5]
                  .map(
                    (rating) => ChoiceChip(
                      showCheckmark: false,
                      selected: _rating == rating,
                      onSelected: (_) => setState(() => _rating = rating),
                      side: BorderSide(
                        color: _rating == rating
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
                              color: _rating == rating
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
              onPressed: () => Navigator.pop(context, _filterCount),
            ),
          ],
        ),
      ),
    );
  }
}
