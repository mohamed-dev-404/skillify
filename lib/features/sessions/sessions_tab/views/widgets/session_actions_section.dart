import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skillify/features/sessions/accept_session/views/accept_session_button.dart';
import 'package:skillify/features/sessions/cancel_session/views/cancel_session_button.dart';
import 'package:skillify/features/sessions/data/models/session_model.dart';
import 'package:skillify/features/sessions/decline_session/views/decline_session_button.dart';
import 'package:skillify/features/sessions/join_session/views/join_session_button.dart';
import 'package:skillify/features/sessions/reschedule_session/views/reschedule_session_button.dart';
import 'package:skillify/features/sessions/sessions_tab/views/widgets/session_ui_helper.dart';

class SessionActionsSection extends StatelessWidget {
  const SessionActionsSection({
    super.key,
    required this.session,
    this.shouldBack = false,
    this.onSuccess,
  });

  final SessionModel session;
  final bool shouldBack;
  final VoidCallback? onSuccess;

  @override
  Widget build(BuildContext context) {
    if (!session.hasActions) return const SizedBox.shrink();

    final actions = _resolveActions(session, shouldBack, onSuccess);
    if (actions.isEmpty) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (actions.joinButton != null) ...[
          actions.joinButton!,
          if (actions.secondaryButtons.isNotEmpty) const Gap(10),
        ],
        if (actions.secondaryButtons.isNotEmpty)
          Row(
            children: _intersperse(
              actions.secondaryButtons,
              const Gap(10),
            ).toList(),
          ),
      ],
    );
  }

  Iterable<Widget> _intersperse(List<Widget> items, Widget separator) sync* {
    for (var i = 0; i < items.length; i++) {
      if (i > 0) yield separator;
      yield items[i];
    }
  }

  _ResolvedActions _resolveActions(
    SessionModel session,
    bool shouldBack,
    VoidCallback? onSuccess,
  ) {
    Widget? joinButton;
    final secondary = <Widget>[];

    switch (session.sessionStatus) {
      case SessionStatus.pending:
        if (session.isRequested) {
          secondary.addAll([
            Expanded(
              child: CancelSessionButton(
                sessionId: session.id,
                minHeight: 42,
                shouldBack: shouldBack,
                onSuccess: onSuccess,
              ),
            ),
            Expanded(
              child: RescheduleSessionButton(
                sessionId: session.id,
                minHeight: 42,
                onSuccess: onSuccess,
              ),
            ),
          ]);
        } else {
          secondary.addAll([
            Expanded(
              child: AcceptSessionButton(
                sessionId: session.id,
                minHeight: 42,
                shouldBack: shouldBack,
                onSuccess: onSuccess,
              ),
            ),
            Expanded(
              child: DeclineSessionButton(
                sessionId: session.id,
                minHeight: 42,
                shouldBack: shouldBack,
                onSuccess: onSuccess,
              ),
            ),
            Expanded(
              child: RescheduleSessionButton(
                sessionId: session.id,
                minHeight: 42,
                onSuccess: onSuccess,
              ),
            ),
          ]);
        }
        break;

      case SessionStatus.reOffered:
        if (session.pendingRescheduleByUser) {
          // No actions allowed when waiting for the other participant to respond
        } else {
          secondary.addAll([
            Expanded(
              child: AcceptSessionButton(
                sessionId: session.id,
                minHeight: 42,
                shouldBack: shouldBack,
                onSuccess: onSuccess,
              ),
            ),
            Expanded(
              child: CancelSessionButton(
                sessionId: session.id,
                minHeight: 42,
                shouldBack: shouldBack,
                onSuccess: onSuccess,
              ),
            ),
            Expanded(
              child: RescheduleSessionButton(
                sessionId: session.id,
                minHeight: 42,
                onSuccess: onSuccess,
              ),
            ),
          ]);
        }
        break;

      case SessionStatus.active:
        joinButton = JoinSessionButton(
          params: session.callViewParams,
          isCompact: true,
          minWidth: double.infinity,
          minHeight: 40,
          borderRadius: 12,
        );
        break;

      case SessionStatus.accepted:
      case SessionStatus.completed:
      case SessionStatus.declined:
      case SessionStatus.cancelled:
      case SessionStatus.expired:
        break;
    }

    return _ResolvedActions(
      joinButton: joinButton,
      secondaryButtons: secondary,
    );
  }
}

class _ResolvedActions {
  final Widget? joinButton;
  final List<Widget> secondaryButtons;

  const _ResolvedActions({
    this.joinButton,
    this.secondaryButtons = const [],
  });

  bool get isEmpty => joinButton == null && secondaryButtons.isEmpty;
}
