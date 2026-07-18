import 'package:flutter/material.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/features/explore/data/models/public_profile/public_profile_model.dart';
import 'label.dart';

class RequestSessionSkillField extends StatelessWidget {
  const RequestSessionSkillField({
    super.key,
    required this.profile,
  });

  final PublicProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Label('Skill'),
        const SizedBox(height: 8),
        FormField<int?>(
          initialValue: profile.offeredSkill?.mainSkill?.id,
          validator: (_) {
            return (profile.offeredSkill == null ||
                    profile.offeredSkill?.mainSkill == null)
                ? 'Please select a skill'
                : null;
          },
          builder: (field) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue:
                      profile.offeredSkill?.mainSkill?.name ??
                      'No skill available',
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
}
