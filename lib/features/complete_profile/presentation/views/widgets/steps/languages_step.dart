import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:skillify/features/complete_profile/presentation/view_model/complete_profile_cubit/complete_profile_cubit.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/selectable_chip.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/step_title.dart';

/// Step 3: multi-select the languages the user can teach in.
class LanguagesStep extends StatelessWidget {
  const LanguagesStep({super.key});

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
                title: 'Which languages can you teach in?',
                subtitle:
                    'Select all the languages you are comfortable conducting a session in. You can update these later.',
              ),
              const Gap(32),
              Wrap(
                spacing: 8,
                runSpacing: 12,
                children: [
                  for (final language in cubit.languages)
                    SelectableChip(
                      label: language.name,
                      isSelected: cubit.selectedLanguageIds.contains(
                        language.id,
                      ),
                      onTap: () => cubit.toggleLanguage(language.id),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
