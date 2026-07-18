import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/common/app_dialogs.dart';
import 'package:skillify/core/common/app_snack_bar.dart';
import 'package:skillify/core/functions/time_of_day.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/features/explore/data/models/public_profile/public_profile_model.dart';
import 'package:skillify/features/explore/data/models/request_session/request_session_request.dart';
import 'package:skillify/features/explore/request_session/presentation/view_model/request_session_cubit/request_session_cubit.dart';
import '../widgets/profile_summary.dart';
import '../widgets/request_session_duration_section.dart';
import '../widgets/request_session_input_section.dart';
import '../widgets/request_session_schedule_section.dart';
import '../widgets/request_session_skill_field.dart';
import '../widgets/sheet_header.dart';
import '../widgets/submit_area.dart';

class RequestSessionSheet extends StatefulWidget {
  const RequestSessionSheet({
    super.key,
    required this.profile,
  });

  final PublicProfileModel profile;

  @override
  State<RequestSessionSheet> createState() => _RequestSessionSheetState();
}

class _RequestSessionSheetState extends State<RequestSessionSheet> {
  final _formKey = GlobalKey<FormState>();
  String _topic = '';
  String _message = '';
  DateTime? _date;
  TimeOfDayValue? _time;
  int _durationMinutes = 30;

  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestSessionCubit, RequestSessionState>(
      listener: (context, state) {
        if (state is RequestSessionLoading) {
          setState(() => _isSubmitting = true);
        } else if (state is RequestSessionSuccess) {
          setState(() => _isSubmitting = false);
          AppDialogs.showAlertDialog(
            context,
            title: 'Request Sent',
            subtitle: 'Your session request was sent successfully.',
            icon: Icons.check_circle_outline_rounded,
            iconColor: AppColors.successNormal,
            ok: 'OK',
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          );
        } else if (state is RequestSessionFailure) {
          setState(() => _isSubmitting = false);
          AppSnackBar.error(
            context,
            state.errorMessage ?? 'An error occurred. Please try again.',
          );
        }
      },
      child: FractionallySizedBox(
        heightFactor: 0.94,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(28),
          ),
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: AppColors.backgroundNormal,
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                children: [
                  const SheetHeader(title: 'Request Session'),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                        20,
                        16,
                        20,
                        24 + MediaQuery.viewInsetsOf(context).bottom,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProfileSummary(profile: widget.profile),
                            const Gap(24),
                            RequestSessionSkillField(profile: widget.profile),
                            const Gap(20),
                            RequestSessionInputSection(
                              label: 'Topic',
                              hint: 'What would you like help with?',
                              onChanged: (value) {
                                setState(() => _topic = value);
                              },
                              validator: (v) => v == null || v.trim().isEmpty
                                  ? 'Please enter a topic'
                                  : null,
                            ),
                            const Gap(20),
                            RequestSessionInputSection(
                              label: "Tell them what you'd like help with",
                              hint: 'Describe your learning goal...',
                              maxLines: 5,
                              onChanged: (value) {
                                setState(() => _message = value);
                              },
                              validator: (v) => v == null || v.trim().isEmpty
                                  ? 'Please enter a description'
                                  : null,
                            ),
                            const Gap(24),
                            RequestSessionScheduleSection(
                              date: _date,
                              time: _time,
                              onDatePicked: (date) {
                                setState(() => _date = date);
                              },
                              onTimePicked: (time) {
                                setState(() => _time = time);
                              },
                            ),
                            const Gap(24),
                            RequestSessionDurationSection(
                              selectedMinutes: _durationMinutes,
                              onChanged: (minutes) {
                                setState(() => _durationMinutes = minutes);
                              },
                              cost: _calculateCost(_durationMinutes),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SubmitArea(
                    text: 'Request Session',
                    isLoading: _isSubmitting,
                    onPressed: !_isSubmitting
                        ? () {
                            if (_formKey.currentState?.validate() ?? false) {
                              if (_date == null || _time == null) {
                                AppSnackBar.warning(
                                  context,
                                  'Please pick a date and time',
                                );
                                return;
                              }

                              _submit();
                            }
                          }
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// TODO: change it based on the actual cost calculation logic
  int _calculateCost(int minutes) {
    return minutes;
  }

  DateTime _combineDateAndTime(DateTime date, TimeOfDayValue time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    ).toUtc();
  }

  void _submit() {
    final selectedSkill = widget.profile.offeredSkill;
    final userId = widget.profile.userId;

    if (selectedSkill == null || selectedSkill.mainSkill == null) {
      AppSnackBar.warning(
        context,
        'Skill information is missing.',
      );
      return;
    }

    context.read<RequestSessionCubit>().requestSession(
      RequestSessionRequest(
        helperId: userId,
        mainSkillId: selectedSkill.mainSkill!.id,
        topic: _topic.trim(),
        problemDescription: _message.trim(),
        durationMinutes: _durationMinutes,
        scheduledAt: _combineDateAndTime(_date!, _time!),
      ),
    );
  }
}
