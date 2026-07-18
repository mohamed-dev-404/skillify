import 'package:skillify/core/services/network/api_consumer.dart';
import 'package:skillify/core/services/network/dio_consumer.dart';
import 'package:skillify/features/auth/data/repo/auth_repo.dart';
import 'package:skillify/features/auth/data/repo/auth_repo_impl.dart';
import 'package:skillify/features/auth/presentation/view_model/login_cubit/login_cubit.dart';
import 'package:skillify/features/auth/presentation/view_model/register_cubit/register_cubit.dart';
import 'package:skillify/features/complete_profile/data/repo/complete_profile_repo.dart';
import 'package:skillify/features/complete_profile/data/repo/complete_profile_repo_impl.dart';
import 'package:skillify/features/complete_profile/presentation/view_model/complete_profile_cubit/complete_profile_cubit.dart';
import 'package:skillify/features/sessions/data/repo/sessions_repo.dart';
import 'package:skillify/features/sessions/data/repo/sessions_repo_impl.dart';
import 'package:skillify/features/sessions/accept_session/view_model/accept_session_cubit/accept_session_cubit.dart';
import 'package:skillify/features/sessions/decline_session/view_model/decline_session_cubit/decline_session_cubit.dart';
import 'package:skillify/features/sessions/cancel_session/view_model/cancel_session_cubit/cancel_session_cubit.dart';
import 'package:skillify/features/sessions/reschedule_session/view_model/reschedule_session_cubit/reschedule_session_cubit.dart';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

/// This file is responsible for registering all the services
/// that will be used in the app using GetIt package for [dependency_injection].
final GetIt getIt = GetIt.instance;

//* This function will be called in the main function before running the app
void setupServiceLocator() {
  //! shared network services
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(getIt<Dio>()));

  //! Auth Feature

  //? Repo
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(getIt<ApiConsumer>()),
  );

  //? Cubits
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(authRepo: getIt<AuthRepo>()),
  );
  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(authRepo: getIt<AuthRepo>()),
  );

  //! Complete Profile Feature

  //? Repo
  getIt.registerLazySingleton<CompleteProfileRepo>(
    () => CompleteProfileRepoImpl(getIt<ApiConsumer>()),
  );

  //? Cubit
  getIt.registerFactory<CompleteProfileCubit>(
    () => CompleteProfileCubit(
      completeProfileRepo: getIt<CompleteProfileRepo>(),
    ),
  );

  //! Profile Feature

  //? Profile Repo
  // getIt.registerLazySingleton<ProfileRepo>(
  //   () => ProfileRepoImpl(getIt<ApiConsumer>()),
  // );

  //? Splash Cubit
  // getIt.registerFactory<SplashCubit>(
  //   () => SplashCubit(profileRepo: getIt<ProfileRepo>()),
  // );

  //! Home Feature

  //? Home Repo
  // getIt.registerLazySingleton<HomeRepo>(
  //   () => HomeRepoImpl(getIt<ApiConsumer>()),
  // );

  //! Sessions Feature

  //? Repo
  getIt.registerLazySingleton<SessionsRepo>(
    () => SessionsRepoImpl(getIt<ApiConsumer>()),
  );

  //? Cubits
  getIt.registerFactory<AcceptSessionCubit>(
    () => AcceptSessionCubit(sessionsRepo: getIt<SessionsRepo>()),
  );
  getIt.registerFactory<DeclineSessionCubit>(
    () => DeclineSessionCubit(sessionsRepo: getIt<SessionsRepo>()),
  );
  getIt.registerFactory<CancelSessionCubit>(
    () => CancelSessionCubit(sessionsRepo: getIt<SessionsRepo>()),
  );
  getIt.registerFactory<RescheduleSessionCubit>(
    () => RescheduleSessionCubit(sessionsRepo: getIt<SessionsRepo>()),
  );
}
