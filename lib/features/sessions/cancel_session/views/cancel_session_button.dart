import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillify/core/common/app_toast.dart';
import 'package:skillify/core/di/service_locator.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/widgets/buttons/main_button.dart';
import 'package:skillify/features/sessions/cancel_session/view_model/cancel_session_cubit/cancel_session_cubit.dart';

class CancelSessionButton extends StatelessWidget {
  final int sessionId;
  final bool shouldBack;
  final double minWidth;
  final double minHeight;

  const CancelSessionButton({
    super.key,
    required this.sessionId,
    this.shouldBack = false,
    this.minWidth = double.infinity,
    this.minHeight = 56,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CancelSessionCubit>(),
      child: BlocConsumer<CancelSessionCubit, CancelSessionState>(
        listener: (context, state) {
          if (state is CancelSessionSuccess) {
            AppToast.success(context, 'Session canceled successfully!');
            if (shouldBack && Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          } else if (state is CancelSessionFailure) {
            AppToast.error(context, state.message);
          }
        },
        builder: (context, state) {
          return MainButton(
            text: 'Cancel',
            bgColor: AppColors.errorNormal,
            minWidth: minWidth,
            minHeight: minHeight,
            isLoading: state is CancelSessionLoading,
            onPressed: () {
              context.read<CancelSessionCubit>().cancel(sessionId: sessionId);
            },
          );
        },
      ),
    );
  }
}
