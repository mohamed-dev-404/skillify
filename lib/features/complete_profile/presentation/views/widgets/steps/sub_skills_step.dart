import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/inputs/app_text_form_field.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/complete_profile_items.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/selectable_chip.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/step_title.dart';

/// Step 5: multi-select the specific sub skills + expertise description.
class SubSkillsStep extends StatefulWidget {
  const SubSkillsStep({super.key});

  @override
  State<SubSkillsStep> createState() => _SubSkillsStepState();
}

class _SubSkillsStepState extends State<SubSkillsStep>
    with AutomaticKeepAliveClientMixin {
  final Set<String> _selectedSkills = {};

  // Keeps the selections alive while navigating between PageView steps.
  @override
  bool get wantKeepAlive => true;

  void _toggle(String skill) {
    setState(() {
      if (!_selectedSkills.remove(skill)) {
        _selectedSkills.add(skill);
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
            title: 'Specify your expertise',
            subtitle:
                'Select the specific areas within Mobile Development where you can offer guidance.',
          ),
          const Gap(32),
          Text(
            'Programming Focus',
            style: AppStyles.bold24.copyWith(color: AppColors.primary),
          ),
          const Gap(16),
          Wrap(
            spacing: 8,
            runSpacing: 12,
            children: [
              for (final skill in CompleteProfileItems.programmingSkills)
                SelectableChip(
                  label: skill,
                  isSelected: _selectedSkills.contains(skill),
                  onTap: () => _toggle(skill),
                ),
            ],
          ),
          const Gap(32),
          Text(
            'Description of expertise',
            style: AppStyles.bold16.copyWith(color: AppColors.primary),
          ),
          const Gap(8),
          Text(
            'Please provide a brief description of your experience with the skills you selected above',
            style: AppStyles.regular14.copyWith(
              color: AppColors.textSecondaryNormal,
            ),
          ),
          const Gap(12),
          const AppTextFormField(
            hintText:
                'I can teach Clean Architecture, state management with Riverpod, and building custom render objects.',
            maxLines: 4,
          ),
        ],
      ),
    );
  }
}
