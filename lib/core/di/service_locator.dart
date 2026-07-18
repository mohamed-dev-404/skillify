import 'package:skillify/core/services/network/api_consumer.dart';
import 'package:skillify/core/services/network/dio_consumer.dart';
import 'package:skillify/features/auth/data/repo/auth_repo.dart';
import 'package:skillify/features/auth/data/repo/auth_repo_impl.dart';
import 'package:skillify/features/auth/presentation/view_model/login_cubit/login_cubit.dart';
import 'package:skillify/features/auth/presentation/view_model/register_cubit/register_cubit.dart';
import 'package:skillify/features/complete_profile/data/repo/complete_profile_repo.dart';
import 'package:skillify/features/complete_profile/data/repo/complete_profile_repo_impl.dart';
import 'package:skillify/features/complete_profile/presentation/view_model/complete_profile_cubit/complete_profile_cubit.dart';
import 'package:skillify/features/explore/data/repo/explore_repo.dart';
import 'package:skillify/features/explore/data/repo/explore_repo_impl.dart';
import 'package:skillify/features/explore/offer_session/presentation/view_model/request_session_cubit/offer_session_cubit.dart';
import 'package:skillify/features/explore/request_session/presentation/view_model/request_session_cubit/request_session_cubit.dart';
import 'package:skillify/features/profile/data/repo/profile_repo.dart';
import 'package:skillify/features/profile/data/repo/profile_repo_impl.dart';
import 'package:skillify/features/profile/my_profile/view_model/profile_cubit/profile_cubit.dart';
import 'package:skillify/features/settings/presentation/view_model/logout_cubit/logout_cubit.dart';
import 'package:skillify/features/wallet/data/repo/wallet_repo.dart';
import 'package:skillify/features/wallet/data/repo/wallet_repo_impl.dart';
import 'package:skillify/features/wallet/presentation/view_model/wallet_cubit/wallet_cubit.dart';
import 'package:skillify/features/profile/edit_profile/view_model/edit_profile_cubit/edit_profile_cubit.dart';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:skillify/features/explore/explore/presentation/view_model/explore_cubit/explore_cubit.dart';
import 'package:skillify/features/explore/public_profile/presentation/view_model/public_profile_cubit/public_profile_cubit.dart';

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
  getIt.registerFactory<LogoutCubit>(
    () => LogoutCubit(getIt<AuthRepo>()),
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

  //! Explore Feature

  //? Repo
  getIt.registerLazySingleton<ExploreRepo>(
    () => ExploreRepoImpl(getIt<ApiConsumer>()),
  );

  //? Cubit
  getIt.registerFactory<ExploreCubit>(
    () => ExploreCubit(
      exploreRepo: getIt<ExploreRepo>(),
      completeProfileRepo: getIt<CompleteProfileRepo>(),
    ),
  );

  //! Wallet Feature

  //? Repo
  getIt.registerLazySingleton<WalletRepo>(
    () => WalletRepoImpl(getIt<ApiConsumer>()),
  );

  //? Cubit
  getIt.registerFactory<WalletCubit>(
    () => WalletCubit(walletRepo: getIt<WalletRepo>()),
  );

  getIt.registerFactory<PublicProfileCubit>(
    () => PublicProfileCubit(exploreRepo: getIt<ExploreRepo>()),
  );
  getIt.registerFactory<RequestSessionCubit>(
    () => RequestSessionCubit(getIt<ExploreRepo>()),
  );

  getIt.registerFactory<OfferSessionCubit>(
    () => OfferSessionCubit(getIt<ExploreRepo>()),
  );

  //! Profile Feature

  //? Profile Repo
  // getIt.registerLazySingleton<ProfileRepo>(
  //   () => ProfileRepoImpl(getIt<ApiConsumer>()),
  // );
  getIt.registerLazySingleton<ProfileRepo>(
    () => ProfileRepoImpl(getIt<ApiConsumer>()),
  );

  //? Profile Cubit
  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(profileRepo: getIt<ProfileRepo>()),
  );

  getIt.registerFactory<EditProfileCubit>(
    () => EditProfileCubit(completeProfileRepo: getIt<CompleteProfileRepo>()),
  );

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
