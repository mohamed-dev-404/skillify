import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillify/core/common/app_toast.dart';
import 'package:skillify/core/di/service_locator.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/features/sessions/decline_session/view_model/decline_session_cubit/decline_session_cubit.dart';
import 'package:skillify/features/sessions/sessions_tab/views/widgets/session_action_button.dart';

class DeclineSessionButton extends StatelessWidget {
  final int sessionId;
  final bool shouldBack;
  final double minWidth;
  final double minHeight;
  final VoidCallback? onSuccess;

  const DeclineSessionButton({
    super.key,
    required this.sessionId,
    this.shouldBack = false,
    this.minWidth = double.infinity,
    this.minHeight = 56,
    this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DeclineSessionCubit>(),
      child: BlocConsumer<DeclineSessionCubit, DeclineSessionState>(
        listener: (context, state) {
          if (state is DeclineSessionSuccess) {
            AppToast.success(context, 'Session declined successfully!');
            if (shouldBack && Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            onSuccess?.call();
          } else if (state is DeclineSessionFailure) {
            AppToast.error(context, state.message);
          }
        },
        builder: (context, state) {
          return SessionActionButton(
            label: 'Decline',
            icon: Icons.block_rounded,
            color: AppColors.errorNormal,
            minWidth: minWidth,
            minHeight: minHeight,
            isLoading: state is DeclineSessionLoading,
            onPressed: () {
              context.read<DeclineSessionCubit>().decline(sessionId: sessionId);
            },
          );
        },
      ),
    );
  }
}
