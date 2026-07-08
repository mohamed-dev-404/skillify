import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/custom_svg_picture.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/complete_profile_items.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/selectable_chip.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/step_title.dart';

/// Step 7: multi-select the sub skills to learn under each chosen category.
class NeededSubSkillsStep extends StatefulWidget {
  const NeededSubSkillsStep({super.key});

  @override
  State<NeededSubSkillsStep> createState() => _NeededSubSkillsStepState();
}

class _NeededSubSkillsStepState extends State<NeededSubSkillsStep>
    with AutomaticKeepAliveClientMixin {
  // TODO: build the categories from the step 6 selections when wiring the cubit.
  final _categories = [
    CompleteProfileItems.skillCategories.first,
    CompleteProfileItems.skillCategories[2],
  ];

  final Map<String, Set<String>> _selections = {};

  // Keeps the selections alive while navigating between PageView steps.
  @override
  bool get wantKeepAlive => true;

  void _toggle(String category, String skill) {
    setState(() {
      final selected = _selections.putIfAbsent(category, () => {});
      if (!selected.remove(skill)) {
        selected.add(skill);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StepTitle(
            title: 'Refine your needed skills',
            subtitle:
                'Select the specific sub-skills you want to learn under each main category you chose.',
          ),
          const Gap(24),
          for (final category in _categories) ...[
            _CategorySkillsCard(
              category: category,
              selectedSkills: _selections[category.title] ?? const {},
              onToggle: (skill) => _toggle(category.title, skill),
            ),
            const Gap(20),
          ],
        ],
      ),
    );
  }
}

class _CategorySkillsCard extends StatelessWidget {
  const _CategorySkillsCard({
    required this.category,
    required this.selectedSkills,
    required this.onToggle,
  });

  final SkillCategoryItem category;
  final Set<String> selectedSkills;
  final void Function(String skill) onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundNormal,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomSvgPicture(
                path: category.iconPath,
                width: 22,
                height: 22,
                color: AppColors.primary,
              ),
              const Gap(12),
              Text(
                category.title,
                style: AppStyles.medium20.copyWith(color: AppColors.primary),
              ),
            ],
          ),
          const Gap(12),
          const Divider(),
          const Gap(12),
          Wrap(
            spacing: 8,
            runSpacing: 12,
            children: [
              for (final skill in CompleteProfileItems.programmingSkills)
                SelectableChip(
                  label: skill,
                  isSelected: selectedSkills.contains(skill),
                  onTap: () => onToggle(skill),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
