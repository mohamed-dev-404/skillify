import 'package:flutter/material.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/features/sessions/data/models/session_model.dart';
import 'package:skillify/features/sessions/join_session/models/call_view_params.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SessionUiHelper
// ─────────────────────────────────────────────────────────────────────────────

/// A centralized helper for all session UI/business logic.
extension SessionUiHelper on SessionModel {
  /// Returns the name of the other participant (not the current user).
  String get otherParticipantName => isRequested ? helperName : requesterName;

  /// Returns the initials of the other participant for the avatar.
  String get otherParticipantInitials {
    final name = otherParticipantName.trim();
    if (name.isEmpty) return '?';
    final parts = name.split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }

  /// Returns the most relevant timestamp label for the current status.
  String get relevantTimestampLabel {
    switch (sessionStatus) {
      case SessionStatus.pending:
        return 'Requested';
      case SessionStatus.accepted:
        return 'Scheduled';
      case SessionStatus.active:
        return 'Started';
      case SessionStatus.reOffered:
        return 'Proposed';
      case SessionStatus.completed:
        return 'Completed';
      case SessionStatus.cancelled:
        return 'Cancelled';
      case SessionStatus.declined:
        return 'Declined';
      case SessionStatus.expired:
        return 'Expired';
    }
  }

  /// Returns the most relevant formatted timestamp for the current status.
  String get relevantTimestamp {
    switch (sessionStatus) {
      case SessionStatus.pending:
        return scheduledAtText.isNotEmpty ? scheduledAtText : createdAtText;
      case SessionStatus.accepted:
      case SessionStatus.active:
      case SessionStatus.reOffered:
        return scheduledAtText.isNotEmpty ? scheduledAtText : createdAtText;
      case SessionStatus.completed:
        return completedAtText.isNotEmpty ? completedAtText : createdAtText;
      case SessionStatus.cancelled:
      case SessionStatus.declined:
      case SessionStatus.expired:
        return createdAtText;
    }
  }

  /// Constructs CallViewParams for the Join button from the session data.
  CallViewParams get callViewParams {
    final currentUserId = isRequested ? requesterId : helperId;
    final currentUserName = isRequested ? requesterName : helperName;
    return CallViewParams(
      callID: zegoRoomId ?? '',
      userId: currentUserId.toString(),
      userName: currentUserName,
    );
  }

  /// Whether the session has actions to display.
  bool get hasActions {
    switch (sessionStatus) {
      case SessionStatus.pending:
      case SessionStatus.accepted:
      case SessionStatus.active:
        return true;
      case SessionStatus.reOffered:
        return !pendingRescheduleByUser;
      case SessionStatus.completed:
      case SessionStatus.declined:
      case SessionStatus.cancelled:
      case SessionStatus.expired:
        return false;
    }
  }

  /// Avatar color based on the other participant's name.
  Color get avatarColor {
    const palette = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.accentDark,
      AppColors.successDark,
      AppColors.warningDark,
      AppColors.primaryDark,
      AppColors.secondaryDark,
    ];
    final name = otherParticipantName;
    if (name.isEmpty) return AppColors.primary;
    final index = name.codeUnits.fold<int>(0, (sum, c) => sum + c);
    return palette[index % palette.length];
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// StatusBadgeConfig
// ─────────────────────────────────────────────────────────────────────────────

class StatusBadgeConfig {
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;

  const StatusBadgeConfig({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
  });

  factory StatusBadgeConfig.from(SessionStatus status) {
    switch (status) {
      case SessionStatus.pending:
        return const StatusBadgeConfig(
          label: 'Pending',
          backgroundColor: AppColors.warningLight,
          foregroundColor: AppColors.warningDark,
          icon: Icons.schedule_rounded,
        );
      case SessionStatus.accepted:
        return StatusBadgeConfig(
          label: 'Scheduled',
          backgroundColor: AppColors.accent.withValues(alpha: 0.12),
          foregroundColor: AppColors.accentDark,
          icon: Icons.event_available_rounded,
        );
      case SessionStatus.active:
        return const StatusBadgeConfig(
          label: 'Active',
          backgroundColor: AppColors.successLight,
          foregroundColor: AppColors.successNormal,
          icon: Icons.play_circle_outline_rounded,
        );
      case SessionStatus.reOffered:
        return const StatusBadgeConfig(
          label: 'Re-Offered',
          backgroundColor: AppColors.secondaryLight,
          foregroundColor: AppColors.secondaryDark,
          icon: Icons.update_rounded,
        );
      case SessionStatus.completed:
        return const StatusBadgeConfig(
          label: 'Completed',
          backgroundColor: AppColors.successLight,
          foregroundColor: AppColors.successDark,
          icon: Icons.task_alt_rounded,
        );
      case SessionStatus.declined:
        return const StatusBadgeConfig(
          label: 'Declined',
          backgroundColor: AppColors.errorLight,
          foregroundColor: AppColors.errorNormal,
          icon: Icons.block_rounded,
        );
      case SessionStatus.cancelled:
        return const StatusBadgeConfig(
          label: 'Cancelled',
          backgroundColor: AppColors.errorLight,
          foregroundColor: AppColors.errorDark,
          icon: Icons.cancel_outlined,
        );
      case SessionStatus.expired:
        return const StatusBadgeConfig(
          label: 'Expired',
          backgroundColor: AppColors.textSecondaryLightActive,
          foregroundColor: AppColors.textSecondaryNormal,
          icon: Icons.timer_off_outlined,
        );
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SessionStatusHint
// ─────────────────────────────────────────────────────────────────────────────

class SessionStatusHint {
  /// Returns a helpful message explaining the session's current status.
  static String getHint(SessionModel session) {
    switch (session.sessionStatus) {
      case SessionStatus.pending:
        if (session.isRequested) {
          return 'Waiting for the other participant to respond to your session request.';
        } else {
          return 'You received a session request. Please accept or decline it.';
        }
      case SessionStatus.accepted:
        return 'Both participants accepted this session. You\'ll be able to join the call 2 minutes before the scheduled time.';
      case SessionStatus.active:
        return 'The session is currently live. You can join the call now.';
      case SessionStatus.reOffered:
        if (session.pendingRescheduleByUser) {
          return 'You proposed a new schedule and are waiting for the other participant to respond.';
        } else {
          return 'The other participant proposed a new schedule. Review it and choose whether to accept or propose another time.';
        }
      case SessionStatus.completed:
        return 'This session has ended successfully. You can review your rating below.';
      case SessionStatus.cancelled:
        return 'This session was cancelled and no further actions are available.';
      case SessionStatus.declined:
        return 'The session invitation was declined.';
      case SessionStatus.expired:
        return 'The session expired because it wasn\'t started or handled in time.';
    }
  }
}
