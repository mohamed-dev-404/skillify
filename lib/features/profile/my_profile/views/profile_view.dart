import 'package:flutter/material.dart';
import 'package:skillify/features/profile/my_profile/views/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: ProfileViewBody(),
    );
  }
}
