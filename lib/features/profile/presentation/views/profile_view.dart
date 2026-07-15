import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillify/core/di/service_locator.dart';
import 'package:skillify/features/profile/presentation/view_model/profile_cubit/profile_cubit.dart';
import 'package:skillify/features/profile/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>(),
      child: const SafeArea(
        child: ProfileViewBody(),
      ),
    );
  }
}
