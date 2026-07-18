import 'package:flutter/material.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';

/// A premium action button used for session actions (Accept, Decline, Cancel, Reschedule).
/// Features gradient backgrounds, icon support, subtle shadows, and smooth loading animation.
class SessionActionButton extends StatelessWidget {
  const SessionActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
    this.minWidth = double.infinity,
    this.minHeight = 56,
    this.isLoading = false,
    this.style = SessionActionButtonStyle.filled,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;
  final double minWidth;
  final double minHeight;
  final bool isLoading;
  final SessionActionButtonStyle style;

  @override
  Widget build(BuildContext context) {
    final isFilled = style == SessionActionButtonStyle.filled;
    final isCompact = minHeight <= 44;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      constraints: BoxConstraints(
        minWidth: minWidth,
        minHeight: minHeight,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isCompact ? 10 : 14),
        gradient: isFilled
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color,
                  Color.lerp(color, Colors.black, 0.15)!,
                ],
              )
            : null,
        color: isFilled ? null : color.withValues(alpha: 0.08),
        border: isFilled
            ? null
            : Border.all(
                color: color.withValues(alpha: 0.3),
                width: 1.5,
              ),
        boxShadow: isFilled
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
                BoxShadow(
                  color: color.withValues(alpha: 0.1),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(isCompact ? 10 : 14),
          splashColor: Colors.white.withValues(alpha: 0.15),
          highlightColor: Colors.white.withValues(alpha: 0.08),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isCompact ? 8 : 16,
              vertical: isCompact ? 8 : 12,
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: isLoading
                    ? SizedBox(
                        height: isCompact ? 18 : 22,
                        width: isCompact ? 18 : 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: isFilled
                              ? Colors.white
                              : color,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            icon,
                            size: isCompact ? 16 : 18,
                            color: isFilled
                                ? Colors.white
                                : color,
                          ),
                          SizedBox(width: isCompact ? 4 : 8),
                          Flexible(
                            child: Text(
                              label,
                              style: (isCompact
                                      ? AppStyles.bold12
                                      : AppStyles.bold14)
                                  .copyWith(
                                color: isFilled
                                    ? Colors.white
                                    : color,
                                letterSpacing: 0.3,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum SessionActionButtonStyle { filled, outlined }
