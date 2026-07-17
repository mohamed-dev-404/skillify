import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/buttons/main_button.dart';
import 'package:skillify/core/widgets/inputs/app_text_form_field.dart';
import 'package:skillify/core/common/app_snack_bar.dart';
import 'package:skillify/features/profile/edit_profile/view_model/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:skillify/features/profile/edit_profile/views/widgets/edit_profile_picture_widget.dart';

class EditProfileViewBody extends StatelessWidget {
  const EditProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditProfileCubit>();
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          context.pop(true);
        } else if (state is EditProfileFailure) {
          AppSnackBar.error(context, state.message);
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColors.textPrimaryNormal),
                    onPressed: () => context.pop(),
                  ),
                  const Gap(8),
                  Text(
                    'Edit Profile',
                    style: AppStyles.bold20.copyWith(color: AppColors.textPrimaryNormal),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const EditProfilePictureWidget(),
                      const Gap(32),
                      
                      AppTextFormField(
                        label: 'Full Name',
                        controller: cubit.fullNameController,
                        hintText: 'Enter your full name',
                        validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                      ),
                      const Gap(20),

                      AppTextFormField(
                        label: 'Job Title',
                        controller: cubit.jobTitleController,
                        hintText: 'Enter job title',
                        validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                      ),
                      const Gap(20),

                      AppTextFormField(
                        label: 'Bio',
                        controller: cubit.bioController,
                        maxLines: 4,
                        hintText: 'Enter your bio',
                      ),
                      const Gap(40),

                      MainButton(
                        text: 'Save Changes',
                        isLoading: state is EditProfileLoading,
                        onPressed: () {
                          cubit.submit();
                        },
                      ),
                      const Gap(40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
