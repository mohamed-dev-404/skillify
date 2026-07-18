import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:skillify/core/common/app_toast.dart';
import 'package:skillify/core/di/service_locator.dart';
import 'package:skillify/core/utils/colors/app_colors.dart';
import 'package:skillify/core/utils/styles/app_styles.dart';
import 'package:skillify/core/widgets/buttons/main_button.dart';
import 'package:skillify/core/widgets/inputs/app_text_form_field.dart';
import 'package:skillify/features/sessions/data/models/reschedule_session_request_model.dart';
import 'package:skillify/features/sessions/reschedule_session/view_model/reschedule_session_cubit/reschedule_session_cubit.dart';

class RescheduleSessionBottomSheet extends StatefulWidget {
  final int sessionId;
  final VoidCallback? onSuccess;

  const RescheduleSessionBottomSheet({
    super.key,
    required this.sessionId,
    this.onSuccess,
  });

  @override
  State<RescheduleSessionBottomSheet> createState() =>
      _RescheduleSessionBottomSheetState();
}

class _RescheduleSessionBottomSheetState
    extends State<RescheduleSessionBottomSheet> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final TextEditingController _commentController = TextEditingController();

  String get _formattedDateTime {
    if (_selectedDate == null || _selectedTime == null) return '';
    return '${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')} ${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null && mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (time != null && mounted) {
        setState(() {
          _selectedDate = date;
          _selectedTime = time;
        });
      }
    }
  }

  void _submit(BuildContext context) {
    if (_selectedDate == null || _selectedTime == null) {
      AppToast.error(context, 'Please select a new date and time.');
      return;
    }
    if (_commentController.text.trim().isEmpty) {
      AppToast.error(context, 'Please provide a comment.');
      return;
    }

    final newScheduledAt = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    final request = RescheduleSessionRequestModel(
      newScheduledAt: newScheduledAt,
      comment: _commentController.text.trim(),
    );

    context.read<RescheduleSessionCubit>().reschedule(
      sessionId: widget.sessionId,
      request: request,
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RescheduleSessionCubit>(),
      child: BlocConsumer<RescheduleSessionCubit, RescheduleSessionState>(
        listener: (context, state) {
          if (state is RescheduleSessionSuccess) {
            AppToast.success(context, 'Session rescheduled successfully!');
            widget.onSuccess?.call();
            Navigator.pop(context);
          } else if (state is RescheduleSessionFailure) {
            AppToast.error(context, state.message);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reschedule Session',
                    style: AppStyles.bold20.copyWith(color: AppColors.primary),
                  ),
                  const Gap(24),
                  AppTextFormField(
                    label: 'New Date & Time',
                    hintText: 'Select Date & Time',
                    readOnly: true,
                    controller: TextEditingController(text: _formattedDateTime),
                    onTap: _pickDateTime,
                    prefixIcon: const Icon(
                      Icons.calendar_today,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  const Gap(16),
                  AppTextFormField(
                    label: 'Comment',
                    hintText: 'Why do you want to reschedule?',
                    controller: _commentController,
                    maxLines: 3,
                  ),
                  const Gap(24),
                  MainButton(
                    text: 'Submit Request',
                    isLoading: state is RescheduleSessionLoading,
                    onPressed: () => _submit(context),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
