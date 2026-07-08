import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skillify/core/di/service_locator.dart';
import 'package:skillify/core/routes/routes.dart';
import 'package:skillify/features/auth/presentation/view_model/login_cubit/login_cubit.dart';
import 'package:skillify/features/auth/presentation/view_model/register_cubit/register_cubit.dart';
import 'package:skillify/features/auth/presentation/views/login/login_view.dart';
import 'package:skillify/features/auth/presentation/views/register/register_view.dart';
import 'package:skillify/features/complete_profile/presentation/view_model/complete_profile_cubit/complete_profile_cubit.dart';
import 'package:skillify/features/complete_profile/presentation/views/complete_profile/complete_profile_view.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final router = GoRouter(
    // TODO: restore Routes.splash as initial location when splash is ready
    initialLocation: Routes.login,
    routes: [
      //* Splash view
      // GoRoute(
      //   path: Routes.splash,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => getIt<SplashCubit>()..getInitData(),
      //     child: const SplashView(),
      //   ),
      // ),

      //* Login view
      GoRoute(
        path: Routes.login,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<LoginCubit>(),
          child: const LoginView(),
        ),
      ),

      //* Register view
      GoRoute(
        path: Routes.register,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<RegisterCubit>(),
          child: const RegisterView(),
        ),
      ),

      //* Complete profile view
      GoRoute(
        path: Routes.completeProfile,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<CompleteProfileCubit>()..loadLookups(),
          child: const CompleteProfileView(),
        ),
      ),

      //* Main view
      // GoRoute(
      //   path: Routes.main,
      //   builder: (context, state) => const MainAppView(),
      // ),
    ],
  );
}
