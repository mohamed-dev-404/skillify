import 'package:flutter/material.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/widgets/buttons/main_button.dart';

class SubmitArea extends StatelessWidget {
  const SubmitArea({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    Key? key,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        16,
        20,
        16 + MediaQuery.viewPaddingOf(context).bottom,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundNormal,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: MainButton(
        text: text,
        onPressed: onPressed,
        isLoading: isLoading,
      ),
    );
  }
}
