import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:skillify/core/constants/app_constants.dart';
import 'package:skillify/features/sessions/join_session/models/call_view_params.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallView extends StatelessWidget {
  const CallView({
    super.key,
    required this.params,
  });

  final CallViewParams params;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: AppConstants.zegoAppID,
      appSign: AppConstants.zegoAppSign,
      userID: params.userId,
      userName: params.userName,
      callID: params.callID,
      onDispose: () {
        //Callback when the page is destroyed.
        log('CallView disposed');
      },
      events: ZegoUIKitPrebuiltCallEvents(
        // onCallEnd: (event, defaultAction) {
        //   log(
        //     'Call ended, reason: ${event.reason}, kickerUserID: ${event.kickerUserID}',
        //   );
        //   This callback is triggered when call end, you can differentiate the reasons for call end by using the [event.reason], if the call end reason is due to being kicked, you can determine who initiated the kick by using the variable [event.kickerUserID].
        //   The default behavior is to return to the previous page or hide the minimize page. like following:
        // },
      ),
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
