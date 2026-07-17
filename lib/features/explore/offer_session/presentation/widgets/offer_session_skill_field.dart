import 'package:flutter/material.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/features/explore/data/models/public_profile/public_profile_model.dart';
import 'package:skillify/features/explore/data/models/public_profile/public_profile_skill_model.dart';
import 'package:skillify/features/explore/request_session/presentation/widgets/label.dart';

class OfferSessionSkillField extends StatelessWidget {
  const OfferSessionSkillField({
    super.key,
    required this.profile,
  });

  final PublicProfileModel profile;

  @override
  Widget build(BuildContext context) {
    final selectedSkill = _resolveSkill();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Label('Skill'),
        const SizedBox(height: 8),
        FormField<int?>(
          initialValue: selectedSkill?.mainSkill?.id,
          validator: (_) {
            return (selectedSkill == null || selectedSkill.mainSkill == null)
                ? 'Please select a skill'
                : null;
          },
          builder: (field) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue:
                      selectedSkill?.mainSkill?.name ?? 'No skill available',
                  enabled: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.backgroundNormal,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: AppColors.borderNormal,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: AppColors.borderNormal,
                      ),
                    ),
                  ),
                ),
                if (field.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8),
                    child: Text(
                      field.errorText!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  PublicProfileSkillModel? _resolveSkill() {
    if (profile.neededSkills.isNotEmpty) {
      return profile.neededSkills.first;
    }

    return profile.offeredSkill;
  }
}
