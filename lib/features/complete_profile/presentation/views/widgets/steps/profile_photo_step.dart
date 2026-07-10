import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skillify/core/common/app_snack_bar.dart';
import 'package:skillify/core/utils/assets/app_icons.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/custom_svg_picture.dart';
import 'package:skillify/features/complete_profile/presentation/view_model/complete_profile_cubit/complete_profile_cubit.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/step_title.dart';

/// Step 1: upload a profile photo.
class ProfilePhotoStep extends StatelessWidget {
  const ProfilePhotoStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
      builder: (context, state) {
        final photo = context.read<CompleteProfileCubit>().photo;
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
                    _Avatar(photo: photo),
                    const Gap(20),
                    Text(
                      'Upload Photo',
                      style: AppStyles.bold15.copyWith(
                        color: AppColors.primary,
                      ),
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
      },
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({this.photo});

  final File? photo;

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final cubit = context.read<CompleteProfileCubit>();
    try {
      final picked = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1024,
        imageQuality: 85,
      );
      if (picked != null) cubit.setPhoto(File(picked.path));
    } catch (_) {
      if (context.mounted) {
        AppSnackBar.error(context, 'Could not pick the image. Try again');
      }
    }
  }

  void _showPhotoSourceSheet(BuildContext context) {
    final cubit = context.read<CompleteProfileCubit>();
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundNormal,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(8),
            ListTile(
              leading: const Icon(
                Icons.photo_camera_outlined,
                color: AppColors.primary,
              ),
              title: Text(
                'Take a photo',
                style: AppStyles.medium15.copyWith(color: AppColors.primary),
              ),
              onTap: () {
                Navigator.pop(sheetContext);
                _pickImage(context, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.photo_library_outlined,
                color: AppColors.primary,
              ),
              title: Text(
                'Choose from gallery',
                style: AppStyles.medium15.copyWith(color: AppColors.primary),
              ),
              onTap: () {
                Navigator.pop(sheetContext);
                _pickImage(context, ImageSource.gallery);
              },
            ),
            if (photo != null)
              ListTile(
                leading: const Icon(
                  Icons.delete_outline,
                  color: AppColors.errorNormal,
                ),
                title: Text(
                  'Remove photo',
                  style: AppStyles.medium15.copyWith(
                    color: AppColors.errorNormal,
                  ),
                ),
                onTap: () {
                  Navigator.pop(sheetContext);
                  cubit.setPhoto(null);
                },
              ),
            const Gap(8),
          ],
        ),
      ),
    );
  }

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
              image: photo != null
                  ? DecorationImage(
                      image: FileImage(photo!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: photo == null
                ? const CustomSvgPicture(
                    path: AppIcons.userSvg,
                    width: 44,
                    height: 44,
                    color: AppColors.primary,
                  )
                : null,
          ),
          PositionedDirectional(
            bottom: 0,
            end: 0,
            child: GestureDetector(
              onTap: () => _showPhotoSourceSheet(context),
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
