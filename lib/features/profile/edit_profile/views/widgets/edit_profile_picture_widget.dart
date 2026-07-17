import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/features/profile/edit_profile/view_model/edit_profile_cubit/edit_profile_cubit.dart';

class EditProfilePictureWidget extends StatelessWidget {
  const EditProfilePictureWidget({super.key});

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (context.mounted) {
        context.read<EditProfileCubit>().pickImage(File(pickedFile.path));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        final cubit = context.read<EditProfileCubit>();
        final localFile = cubit.profileImage;
        final networkUrl = cubit.initialProfile?.profilePictureUrl;

        return Center(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.secondary, width: 3),
                ),
                child: ClipOval(
                  child: localFile != null
                      ? Image.file(
                          localFile,
                          fit: BoxFit.cover,
                        )
                      : (networkUrl != null && networkUrl.isNotEmpty)
                          ? Image.network(
                              networkUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.person, size: 50, color: AppColors.primary),
                            )
                          : Container(
                              color: AppColors.primaryLight,
                              child: const Icon(Icons.person, size: 50, color: AppColors.primary),
                            ),
                ),
              ),
              GestureDetector(
                onTap: () => _pickImage(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
