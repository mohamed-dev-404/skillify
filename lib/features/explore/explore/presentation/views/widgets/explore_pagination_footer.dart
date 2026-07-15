import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/animated_loading_widget.dart';

class ExplorePaginationFooter extends StatelessWidget {
  const ExplorePaginationFooter({
    super.key,
    required this.isLoading,
    required this.onRetry,
    this.errorMessage,
  });

  final bool isLoading;
  final String? errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (!isLoading && errorMessage == null) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: isLoading
            ? const AnimatedLoadingWidget(height: 56)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    size: 18,
                    color: AppColors.errorNormal,
                  ),
                  const Gap(7),
                  Flexible(
                    child: Text(
                      errorMessage!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.regular12.copyWith(
                        color: AppColors.textSecondaryNormal,
                      ),
                    ),
                  ),
                  const Gap(8),
                  TextButton(onPressed: onRetry, child: const Text('Retry')),
                ],
              ),
      ),
    );
  }
}
