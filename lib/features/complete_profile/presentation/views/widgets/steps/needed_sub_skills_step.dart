import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/assets/app_icons.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/custom_svg_picture.dart';
import 'package:skillify/features/complete_profile/data/models/main_skill_model.dart';
import 'package:skillify/features/complete_profile/presentation/view_model/complete_profile_cubit/complete_profile_cubit.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/selectable_chip.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/step_title.dart';

/// Step 7: multi-select the sub skills to learn under each chosen category.
class NeededSubSkillsStep extends StatelessWidget {
  const NeededSubSkillsStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
      builder: (context, state) {
        final cubit = context.read<CompleteProfileCubit>();
        final neededSkills = cubit.neededMainSkills;

        if (neededSkills.isEmpty) {
          return const Center(
            child: StepTitle(
              title: 'Select skills to learn first',
              subtitle:
                  'Go back one step and choose the skills you want to develop.',
            ),
          );
        }

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
              for (final skill in neededSkills) ...[
                _CategorySkillsCard(
                  skill: skill,
                  selectedSkillIds:
                      cubit.neededSubSkillIds[skill.id] ?? const {},
                  onToggle: (subSkillId) =>
                      cubit.toggleNeededSubSkill(skill.id, subSkillId),
                ),
                const Gap(20),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _CategorySkillsCard extends StatelessWidget {
  const _CategorySkillsCard({
    required this.skill,
    required this.selectedSkillIds,
    required this.onToggle,
  });

  final MainSkillModel skill;
  final Set<int> selectedSkillIds;
  final void Function(int subSkillId) onToggle;

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
              const CustomSvgPicture(
                path: AppIcons.briefcaseSvg,
                width: 22,
                height: 22,
                color: AppColors.primary,
              ),
              const Gap(12),
              Text(
                skill.name,
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
              for (final subSkill in skill.subSkills)
                SelectableChip(
                  label: subSkill.name,
                  isSelected: selectedSkillIds.contains(subSkill.id),
                  onTap: () => onToggle(subSkill.id),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
