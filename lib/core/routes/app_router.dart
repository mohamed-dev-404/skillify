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
import 'package:skillify/features/sessions/join_session/views/call_view.dart';
import 'package:skillify/features/sessions/join_session/models/call_view_params.dart';
import 'package:skillify/features/sessions/sessions_tab/views/session_details.dart';
import 'package:skillify/features/sessions/data/models/session_model.dart';

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

      //* Call view
      GoRoute(
        path: Routes.callView,
        builder: (context, state) {
          final params = state.extra as CallViewParams?;
          if (params == null) {
            return const Scaffold(
              body: Center(
                child: Text(
                  'CallView requires CallViewParams passed via extra.',
                ),
              ),
            );
          }
          return CallView(params: params);
        },
      ),

      //* Session Details view
      GoRoute(
        path: Routes.sessionDetails,
        builder: (context, state) {
          final session = state.extra as SessionModel?;
          if (session == null) {
            return const Scaffold(
              body: Center(
                child: Text(
                  'Session details require a SessionModel passed via extra.',
                ),
              ),
            );
          }
          return SessionDetailsView(session: session);
        },
      ),
    ],
  );
}
