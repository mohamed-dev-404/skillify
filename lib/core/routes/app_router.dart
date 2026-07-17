import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skillify/core/di/service_locator.dart';
import 'package:skillify/core/routes/routes.dart';
import 'package:skillify/features/auth/presentation/view_model/login_cubit/login_cubit.dart';
import 'package:skillify/features/auth/presentation/view_model/register_cubit/register_cubit.dart';
import 'package:skillify/features/auth/presentation/views/login/login_view.dart';
import 'package:skillify/features/auth/presentation/views/register/register_view.dart';
import 'package:skillify/features/main/main_app_view.dart';
import 'package:skillify/features/complete_profile/presentation/view_model/complete_profile_cubit/complete_profile_cubit.dart';
import 'package:skillify/features/complete_profile/presentation/views/complete_profile/complete_profile_view.dart';
import 'package:skillify/features/profile/data/models/profile_model.dart';
import 'package:skillify/features/profile/my_profile/views/profile_view.dart';
import 'package:skillify/features/profile/edit_profile/views/edit_profile_view.dart';
import 'package:skillify/features/explore/public_profile/presentation/view_model/public_profile_cubit/public_profile_cubit.dart';
import 'package:skillify/features/explore/public_profile/presentation/views/public_profile_view.dart';

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

      // * Main view
      GoRoute(
        path: Routes.main,
        builder: (context, state) => const MainAppView(),
      ),

      // * Public profile view
      GoRoute(
        path: Routes.publicProfilePath,
        builder: (context, state) {
          final userId =
              int.tryParse(
                state.pathParameters['userId'] ?? '',
              ) ??
              0;

          return BlocProvider(
            create: (context) =>
                getIt<PublicProfileCubit>()..getPublicProfile(userId),
            child: const PublicProfileView(),
          );
        },
      ),

      // * Profile view
      GoRoute(
        path: Routes.profile,
        builder: (context, state) => const ProfileView(),
      ),

      // * Edit Profile view
      GoRoute(
        path: Routes.editProfile,
        builder: (context, state) {
          final profile = state.extra as ProfileModel;
          return EditProfileView(profile: profile);
        },
      ),
    ],
  );
}
