import 'package:flutter/material.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/features/explore/data/models/public_profile/public_profile_skill_model.dart';
import 'widgets_helpers.dart';
import 'label.dart';

class SkillDropdown extends StatelessWidget {
  const SkillDropdown({
    required this.label,
    required this.value,
    required this.skills,
    required this.onChanged,
    this.validator,
    Key? key,
  }) : super(key: key);

  final String label;
  final PublicProfileSkillModel? value;
  final List<PublicProfileSkillModel> skills;
  final ValueChanged<PublicProfileSkillModel?> onChanged;
  final String? Function(PublicProfileSkillModel?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Label(label),
        const SizedBox(height: 8),
        DropdownButtonFormField<PublicProfileSkillModel>(
          value: value,
          items: skills.map((skill) {
            return DropdownMenuItem(
              value: skill,
              child: Text(skill.mainSkill?.name ?? 'Unknown skill'),
            );
          }).toList(),
          onChanged: skills.isEmpty ? null : onChanged,
          validator: validator,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 30),
          decoration: inputDecoration(
            hint: skills.isEmpty ? 'No skill available' : null,
          ),
          style: AppStyles.regular16.copyWith(
            color: AppColors.textPrimaryNormal,
          ),
          dropdownColor: AppColors.backgroundNormal,
        ),
      ],
    );
  }
}
