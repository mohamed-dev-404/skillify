import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skillify/core/routes/routes.dart';
import 'package:skillify/features/auth/presentation/views/login/login_view.dart';
import 'package:skillify/features/auth/presentation/views/register/register_view.dart';
import 'package:skillify/features/main/main_app_view.dart';

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
        builder: (context, state) => const LoginView(),
      ),

      //* Register view
      GoRoute(
        path: Routes.register,
        builder: (context, state) => const RegisterView(),
      ),

      // * Main view
      GoRoute(
        path: Routes.main,
        builder: (context, state) => const MainAppView(),
      ),
    ],
  );
}
