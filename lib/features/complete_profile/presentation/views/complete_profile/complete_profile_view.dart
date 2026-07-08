import 'package:flutter/material.dart';
import 'package:skillify/core/widgets/app_scaffold.dart';
import 'package:skillify/core/widgets/my_body_view.dart';
import 'package:skillify/features/complete_profile/presentation/views/widgets/complete_profile_view_body.dart';

class CompleteProfileView extends StatelessWidget {
  const CompleteProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: SafeArea(
        child: MyBodyView(child: CompleteProfileViewBody()),
      ),
    );
  }
}
