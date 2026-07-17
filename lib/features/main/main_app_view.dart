import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:skillify/core/di/service_locator.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/app_scaffold.dart';
import 'package:skillify/features/explore/explore/presentation/view_model/explore_cubit/explore_cubit.dart';
import 'package:skillify/features/explore/explore/presentation/views/explore_view.dart';
import 'package:skillify/features/profile/my_profile/view_model/profile_cubit/profile_cubit.dart';
import 'package:skillify/features/profile/my_profile/views/profile_view.dart';
import 'package:skillify/features/sessions/presentation/views/sessions_view.dart';
import 'package:skillify/features/wallet/presentation/view_model/wallet_cubit/wallet_cubit.dart';
import 'package:skillify/features/wallet/presentation/views/wallet_view.dart';

class MainAppView extends StatefulWidget {
  const MainAppView({super.key});

  @override
  State<MainAppView> createState() => _MainAppViewState();
}

class _MainAppViewState extends State<MainAppView> {
  int currentIndex = 0;

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      BlocProvider(
        create: (context) => getIt<ExploreCubit>()..initialize(),
        child: const ExploreView(),
      ),
      const SessionsView(),
      BlocProvider(
        create: (context) => getIt<WalletCubit>()..fetchWalletData(),
        child: const WalletView(),
      ),
      BlocProvider(
        create: (context) => getIt<ProfileCubit>(),
        child: const ProfileView(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          right: 16.0,
          left: 16.0,
          bottom: 16.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundNormal,
            borderRadius: const BorderRadius.all(
              Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: AppColors.primaryDark.withValues(alpha: .1),
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            top:
                false, // Prevents status bar height from causing huge top margin
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              child: GNav(
                rippleColor: AppColors.primaryLightHover,
                hoverColor: AppColors.primaryLight,
                gap: 8,
                activeColor: AppColors.backgroundLight,
                iconSize: 22,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                duration: const Duration(milliseconds: 500),
                tabBackgroundColor: AppColors.primary,
                color: AppColors.textSecondaryNormal,
                textStyle: AppStyles.medium14.copyWith(
                  color: AppColors.backgroundLight,
                ),
                tabs: const [
                  GButton(
                    icon: LineIcons.compass,
                    text: 'Explore',
                  ),
                  GButton(
                    icon: LineIcons.calendar,
                    text: 'Sessions',
                  ),
                  GButton(
                    icon: LineIcons.wallet,
                    text: 'Wallet',
                  ),
                  GButton(
                    icon: LineIcons.user,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: currentIndex,
                onTabChange: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
