import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/routes/navigations_helper.dart';
import 'package:skillify/core/routes/routes.dart';
import 'package:skillify/core/utils/assets/app_icons.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/validators/app_validators.dart';
import 'package:skillify/core/widgets/buttons/main_button.dart';
import 'package:skillify/core/widgets/inputs/app_text_form_field.dart';
import 'package:skillify/core/widgets/inputs/input_icon.dart';
import 'package:skillify/core/widgets/inputs/password_text_form_field.dart';
import 'package:skillify/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:skillify/features/auth/presentation/views/widgets/auth_redirect_text.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegisterPressed() {
    if (_formKey.currentState!.validate()) {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AuthHeader(
            title: 'Create Account',
            subtitle: 'Join a community of practical learners.',
          ),
          const Gap(32),
          AppTextFormField(
            controller: _nameController,
            label: 'Full Name',
            hintText: 'Jane Doe',
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            prefixIcon: const InputIcon(path: AppIcons.userSvg),
            validator: AppValidators.validateName,
          ),
          const Gap(24),
          AppTextFormField(
            controller: _emailController,
            label: 'Email Address',
            hintText: 'name@example.com',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            prefixIcon: const InputIcon(path: AppIcons.mailSvg),
            validator: AppValidators.validateEmail,
          ),
          const Gap(24),
          PasswordTextFormField(
            controller: _passwordController,
            label: 'Password',
            hintText: '••••••••',
            prefixIcon: const InputIcon(path: AppIcons.lockSvg),
            validator: AppValidators.validatePassword,
          ),
          const Gap(24),
          PasswordTextFormField(
            controller: _confirmPasswordController,
            label: 'Confirm Password',
            hintText: '••••••••',
            prefixIcon: const InputIcon(path: AppIcons.lockSvg),
            validator: (value) => AppValidators.validateConfirmPassword(
              value,
              _passwordController.text,
            ),
          ),
          const Gap(32),
          MainButton(
            text: 'Create Account',
            bgColor: AppColors.secondary,
            onPressed: _onRegisterPressed,
          ),
          const Gap(24),
          AuthRedirectText(
            text: 'Already have an account?',
            actionText: 'Login',
            onTap: () => pushReplacement(context, Routes.login),
          ),
        ],
      ),
    );
  }
}
