import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:skillify/core/di/service_locator.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/features/explore/data/models/public_profile/public_profile_model.dart';
import 'package:skillify/features/explore/offer_session/presentation/view_model/request_session_cubit/offer_session_cubit.dart';
import 'package:skillify/features/explore/offer_session/presentation/views/offer_session_sheet.dart';
import 'package:skillify/features/explore/data/repo/explore_repo.dart';

class OfferSessionButton extends StatelessWidget {
  const OfferSessionButton({super.key, required this.profile});

  final PublicProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _openSheet(context),
        icon: const Icon(LineIcons.handshake, size: 16),
        label: const Text(
          'Offer Session',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        style: ElevatedButton.styleFrom(
          elevation: 2,
          shadowColor: AppColors.primary.withValues(alpha: 0.18),
          backgroundColor: AppColors.backgroundNormal,
          foregroundColor: AppColors.primary,
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
        create: (_) => OfferSessionCubit(getIt<ExploreRepo>()),
        child: OfferSessionSheet(profile: profile),
      ),
    );
  }
}
