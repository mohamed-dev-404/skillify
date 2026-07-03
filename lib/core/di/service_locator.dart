import 'package:skillify/core/services/network/api_consumer.dart';
import 'package:skillify/core/services/network/dio_consumer.dart';

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

  //? Auth Repo
  // getIt.registerLazySingleton<AuthRepo>(
  //   () => AuthRepoImpl(getIt<ApiConsumer>()),
  // );

  //? Login Cubit
  // getIt.registerFactory<LoginCubit>(
  //   () => LoginCubit(authRepo: getIt<AuthRepo>()),
  // );

  //? Register Cubit
  // getIt.registerFactory<RegisterCubit>(
  //   () => RegisterCubit(authRepo: getIt<AuthRepo>()),
  // );

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
}
