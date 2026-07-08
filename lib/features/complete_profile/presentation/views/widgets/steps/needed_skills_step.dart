import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/complete_profile_items.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/skill_category_card.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/step_title.dart';

/// Step 6: multi-select the primary skills the user wants to learn.
class NeededSkillsStep extends StatefulWidget {
  const NeededSkillsStep({super.key});

  @override
  State<NeededSkillsStep> createState() => _NeededSkillsStepState();
}

class _NeededSkillsStepState extends State<NeededSkillsStep>
    with AutomaticKeepAliveClientMixin {
  final Set<String> _selectedCategories = {};

  // Keeps the selections alive while navigating between PageView steps.
  @override
  bool get wantKeepAlive => true;

  void _toggle(String category) {
    setState(() {
      if (!_selectedCategories.remove(category)) {
        _selectedCategories.add(category);
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
            title: 'What would you like to learn?',
            subtitle:
                'Select the primary skills you want to develop. This helps us tailor your learning path and connect you with the right mentors.',
          ),
          const Gap(32),
          for (final category in CompleteProfileItems.skillCategories) ...[
            SkillCategoryCard(
              item: category,
              isSelected: _selectedCategories.contains(category.title),
              onTap: () => _toggle(category.title),
            ),
            const Gap(16),
          ],
        ],
      ),
    );
  }
}
