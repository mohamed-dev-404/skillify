import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:skillify/features/complete_profile/presentation/view_model/complete_profile_cubit/complete_profile_cubit.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/skill_category_card.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/step_title.dart';

/// Step 6: multi-select the primary skills the user wants to learn.
class NeededSkillsStep extends StatelessWidget {
  const NeededSkillsStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
      builder: (context, state) {
        final cubit = context.read<CompleteProfileCubit>();
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StepTitle(
                title: 'What would you like to learn?',
                subtitle:
                    'Select the primary skills you want to develop. This helps us tailor your learning path and connect you with the right mentors.',
              ),
              const Gap(32),
              for (final skill in cubit.mainSkills) ...[
                SkillCategoryCard(
                  title: skill.name,
                  isSelected: cubit.neededMainSkillIds.contains(skill.id),
                  onTap: () => cubit.toggleNeededMainSkill(skill.id),
                ),
                const Gap(16),
              ],
            ],
          ),
        );
      },
    );
  }
}
