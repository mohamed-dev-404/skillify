import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillify/core/di/service_locator.dart';
import 'package:skillify/features/profile/data/models/profile_model.dart';
import 'package:skillify/features/profile/edit_profile/view_model/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:skillify/features/profile/edit_profile/views/widgets/edit_profile_view_body.dart';

class EditProfileView extends StatelessWidget {
  final ProfileModel profile;

  const EditProfileView({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EditProfileCubit>()..init(profile),
      child: const Scaffold(
        body: SafeArea(
          child: EditProfileViewBody(),
        ),
      ),
    );
  }
}
