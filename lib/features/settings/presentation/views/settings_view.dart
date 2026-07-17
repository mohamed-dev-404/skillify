import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/app_scaffold.dart';
import 'package:skillify/features/settings/presentation/views/widgets/settings_logout_tile.dart';
import 'package:skillify/features/settings/presentation/views/widgets/settings_option_tile.dart';
import 'package:skillify/features/settings/presentation/views/widgets/settings_premium_card.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsItems = <_SettingsItem>[
      _SettingsItem(
        title: 'Account',
        subtitle: 'Profile, security, and preferences',
        icon: Icons.person_outline_rounded,
        iconColor: AppColors.primary,
      ),
      _SettingsItem(
        title: 'Notifications',
        subtitle: 'Stay updated without the noise',
        icon: Icons.notifications_outlined,
        iconColor: AppColors.secondary,
      ),
      _SettingsItem(
        title: 'Privacy',
        subtitle: 'Manage who sees your information',
        icon: Icons.lock_outline_rounded,
        iconColor: AppColors.accent,
      ),
      _SettingsItem(
        title: 'Appearance',
        subtitle: 'Theme, layout, and visual comfort',
        icon: Icons.palette_outlined,
        iconColor: AppColors.warningNormal,
      ),
      _SettingsItem(
        title: 'Help & Support',
        subtitle: 'Contact us and discover resources',
        icon: Icons.support_agent_outlined,
        iconColor: AppColors.errorNormal,
      ),
    ];

    return AppScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.textPrimaryNormal,
          ),
        ),
        title: Text(
          'Settings',
          style: AppStyles.bold20.copyWith(color: AppColors.textPrimaryNormal),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SettingsPremiumCard(),
              const Gap(20),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight.withOpacity(0.94),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.borderNormal,
                    width: 1.1,
                  ),
                ),
                child: Column(
                  children: List.generate(settingsItems.length, (index) {
                    final item = settingsItems[index];

                    return SettingsOptionTile(
                      title: item.title,
                      subtitle: item.subtitle,
                      icon: item.icon,
                      iconColor: item.iconColor,
                      onTap: () {},
                    );
                  }),
                ),
              ),
              const Gap(20),
              const SettingsLogoutTile(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsItem {
  const _SettingsItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
}
