import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/common/app_snack_bar.dart';
import 'package:skillify/core/functions/hide_keyboard.dart';
import 'package:skillify/core/routes/navigations_helper.dart';
import 'package:skillify/core/routes/routes.dart';
import 'package:skillify/core/utils/assets/app_icons.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/validators/app_validators.dart';
import 'package:skillify/core/widgets/buttons/main_button.dart';
import 'package:skillify/core/widgets/inputs/app_text_form_field.dart';
import 'package:skillify/core/widgets/inputs/input_icon.dart';
import 'package:skillify/core/widgets/inputs/password_text_form_field.dart';
import 'package:skillify/features/auth/presentation/view_model/register_cubit/register_cubit.dart';
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
      hideKeyboard(context);
      context.read<RegisterCubit>().register(
        fullName: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          AppSnackBar.success(context, 'Account created successfully!');
          pushToBase(context, Routes.completeProfile);
        } else if (state is RegisterFailure) {
          AppSnackBar.error(context, state.message);
        }
      },
      child: Form(
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
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) => MainButton(
                text: 'Create Account',
                bgColor: AppColors.secondary,
                isLoading: state is RegisterLoading,
                onPressed: _onRegisterPressed,
              ),
            ),
            const Gap(24),
            AuthRedirectText(
              text: 'Already have an account?',
              actionText: 'Login',
              onTap: () => pushReplacement(context, Routes.login),
            ),
          ],
        ),
      ),
    );
  }
}
