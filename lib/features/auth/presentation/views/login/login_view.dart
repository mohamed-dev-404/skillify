import 'package:flutter/material.dart';
import 'package:skillify/core/widgets/app_scaffold.dart';
import 'package:skillify/core/widgets/my_body_view.dart';
import 'package:skillify/features/auth/presentation/views/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: MyBodyView(child: LoginViewBody()),
        ),
      ),
    );
  }
}
