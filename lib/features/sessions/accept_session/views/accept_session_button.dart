import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillify/core/common/app_toast.dart';
import 'package:skillify/core/di/service_locator.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/widgets/buttons/main_button.dart';
import 'package:skillify/features/sessions/accept_session/view_model/accept_session_cubit/accept_session_cubit.dart';

class AcceptSessionButton extends StatelessWidget {
  final int sessionId;
  final bool shouldBack;
  final double minWidth;
  final double minHeight;

  const AcceptSessionButton({
    super.key,
    required this.sessionId,
    this.shouldBack = false,
    this.minWidth = double.infinity,
    this.minHeight = 56,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AcceptSessionCubit>(),
      child: BlocConsumer<AcceptSessionCubit, AcceptSessionState>(
        listener: (context, state) {
          if (state is AcceptSessionSuccess) {
            AppToast.success(context, 'Session accepted successfully!');
            if (shouldBack && Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          } else if (state is AcceptSessionFailure) {
            AppToast.error(context, state.message);
          }
        },
        builder: (context, state) {
          return MainButton(
            text: 'Accept',
            bgColor: AppColors.successNormal,
            minWidth: minWidth,
            minHeight: minHeight,
            isLoading: state is AcceptSessionLoading,
            onPressed: () {
              context.read<AcceptSessionCubit>().accept(sessionId: sessionId);
            },
          );
        },
      ),
    );
  }
}
