import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:skillify/core/di/service_locator.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/features/explore/data/models/public_profile/public_profile_model.dart';
import 'package:skillify/features/explore/data/repo/explore_repo.dart';
import 'package:skillify/features/explore/request_session/presentation/view_model/request_session_cubit/request_session_cubit.dart';
import 'package:skillify/features/explore/request_session/presentation/views/request_session_sheet.dart';

class RequestSessionButton extends StatelessWidget {
  const RequestSessionButton({super.key, required this.profile});

  final PublicProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _openSheet(context),
        icon: const Icon(LineIcons.calendarCheck, size: 16),
        label: const Text(
          'Request Session',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        style: ElevatedButton.styleFrom(
          elevation: 2,
          shadowColor: AppColors.primary.withValues(alpha: 0.18),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.backgroundNormal,
          textStyle: AppStyles.bold14,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Future<void> _openSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider(
        create: (context) => RequestSessionCubit(getIt<ExploreRepo>()),
        child: RequestSessionSheet(
          profile: profile,
        ),
      ),
    );
  }
}
