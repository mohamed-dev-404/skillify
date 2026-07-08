import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/complete_profile_items.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/selectable_chip.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/step_title.dart';

/// Step 3: multi-select the languages the user can teach in.
class LanguagesStep extends StatefulWidget {
  const LanguagesStep({super.key});

  @override
  State<LanguagesStep> createState() => _LanguagesStepState();
}

class _LanguagesStepState extends State<LanguagesStep>
    with AutomaticKeepAliveClientMixin {
  final Set<String> _selectedLanguages = {};

  // Keeps the selections alive while navigating between PageView steps.
  @override
  bool get wantKeepAlive => true;

  void _toggle(String language) {
    setState(() {
      if (!_selectedLanguages.remove(language)) {
        _selectedLanguages.add(language);
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
            title: 'Which languages can you teach in?',
            subtitle:
                'Select all the languages you are comfortable conducting a session in. You can update these later.',
          ),
          const Gap(32),
          Wrap(
            spacing: 8,
            runSpacing: 12,
            children: [
              for (final language in CompleteProfileItems.languages)
                SelectableChip(
                  label: language,
                  isSelected: _selectedLanguages.contains(language),
                  onTap: () => _toggle(language),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
