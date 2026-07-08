import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/assets/app_icons.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/custom_svg_picture.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/step_title.dart';

/// Step 1: upload a profile photo.
class ProfilePhotoStep extends StatelessWidget {
  const ProfilePhotoStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StepTitle(
            title: 'Add a profile photo',
            subtitle:
                'Adding a photo helps build trust with other professionals on Skillify.',
          ),
          const Gap(32),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 32),
            decoration: BoxDecoration(
              color: AppColors.backgroundNormal,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.06),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                const _AvatarPlaceholder(),
                const Gap(20),
                Text(
                  'Upload Photo',
                  style: AppStyles.bold15.copyWith(color: AppColors.primary),
                ),
                const Gap(8),
                Text(
                  'JPG, GIF or PNG. Max size of 5MB.',
                  style: AppStyles.regular12.copyWith(
                    color: AppColors.textSecondaryNormal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarPlaceholder extends StatelessWidget {
  const _AvatarPlaceholder();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Stack(
        children: [
          Container(
            width: 150,
            height: 150,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.borderNormal,
              border: Border.all(color: AppColors.backgroundNormal, width: 4),
            ),
            child: const CustomSvgPicture(
              path: AppIcons.userSvg,
              width: 44,
              height: 44,
              color: AppColors.primary,
            ),
          ),
          PositionedDirectional(
            bottom: 0,
            end: 0,
            child: GestureDetector(
              onTap: () {
                // TODO: open image picker when the logic is implemented
              },
              child: Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                  border: Border.all(
                    color: AppColors.backgroundNormal,
                    width: 2,
                  ),
                ),
                child: const CustomSvgPicture(
                  path: AppIcons.cameraSvg,
                  width: 20,
                  height: 20,
                  color: AppColors.backgroundNormal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
