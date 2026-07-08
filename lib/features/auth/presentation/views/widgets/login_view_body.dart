import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/common/app_snack_bar.dart';
import 'package:skillify/core/functions/hide_keyboard.dart';
import 'package:skillify/core/routes/navigations_helper.dart';
import 'package:skillify/core/routes/routes.dart';
import 'package:skillify/core/utils/assets/app_icons.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/validators/app_validators.dart';
import 'package:skillify/core/widgets/buttons/main_button.dart';
import 'package:skillify/core/widgets/inputs/app_text_form_field.dart';
import 'package:skillify/core/widgets/inputs/input_icon.dart';
import 'package:skillify/core/widgets/inputs/password_text_form_field.dart';
import 'package:skillify/features/auth/presentation/view_model/login_cubit/login_cubit.dart';
import 'package:skillify/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:skillify/features/auth/presentation/views/widgets/auth_redirect_text.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      hideKeyboard(context);
      context.read<LoginCubit>().login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          AppSnackBar.success(context, 'Welcome back!');
          // TODO: navigate to the main/home screen once it is ready.
          // e.g. context.go(Routes.main);
        } else if (state is LoginFailure) {
          AppSnackBar.error(context, state.message);
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AuthHeader(
              title: 'Welcome back !',
              subtitle: 'Continue your learning journey.',
            ),
            const Gap(32),
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
            const Gap(16),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () {
                  // TODO: navigate to forgot password when the view exists
                },
                child: Text(
                  'Forgot Password?',
                  style: AppStyles.bold15.copyWith(color: AppColors.secondary),
                ),
              ),
            ),
            const Gap(24),
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) => MainButton(
                text: 'Login',
                isLoading: state is LoginLoading,
                onPressed: _onLoginPressed,
              ),
            ),
            const Gap(24),
            AuthRedirectText(
              text: "Don't have an account?",
              actionText: 'Register',
              onTap: () => pushReplacement(context, Routes.register),
            ),
          ],
        ),
      ),
    );
  }
}
