import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/complete_profile_items.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/skill_category_card.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/step_title.dart';

/// Step 4: single-select the primary skill the user can teach.
class MainSkillStep extends StatefulWidget {
  const MainSkillStep({super.key});

  @override
  State<MainSkillStep> createState() => _MainSkillStepState();
}

class _MainSkillStepState extends State<MainSkillStep>
    with AutomaticKeepAliveClientMixin {
  String? _selectedCategory;

  // Keeps the selection alive while navigating between PageView steps.
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StepTitle(
            title: 'What can you teach?',
            subtitle:
                'Select your primary area of expertise. You can add more specific skills later.',
          ),
          const Gap(32),
          for (final category in CompleteProfileItems.skillCategories) ...[
            SkillCategoryCard(
              item: category,
              isSelected: _selectedCategory == category.title,
              onTap: () => setState(() => _selectedCategory = category.title),
            ),
            const Gap(16),
          ],
        ],
      ),
    );
  }
}
