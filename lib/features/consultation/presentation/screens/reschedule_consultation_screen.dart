import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_metric_tile.dart';
import '../../../../core/widgets/app_pill.dart';
import '../../../../core/widgets/app_surface_card.dart';
import '../../../dashboard/presentation/widgets/dashboard_section_top_bar.dart';
import '../models/reschedule_consultation_args.dart';

class RescheduleConsultationScreen extends StatefulWidget {
  const RescheduleConsultationScreen({super.key, required this.args});

  final RescheduleConsultationArgs args;

  @override
  State<RescheduleConsultationScreen> createState() =>
      _RescheduleConsultationScreenState();
}

class _RescheduleConsultationScreenState
    extends State<RescheduleConsultationScreen> {
  static const _dateOptions = <_DateOption>[
    _DateOption(dayLabel: 'MON', dateNumber: '25'),
    _DateOption(dayLabel: 'TUE', dateNumber: '26'),
    _DateOption(dayLabel: 'WED', dateNumber: '27'),
    _DateOption(dayLabel: 'THU', dateNumber: '28'),
    _DateOption(dayLabel: 'FRI', dateNumber: '29'),
  ];

  static const _timeOptions = <_TimeOption>[
    _TimeOption(label: '09:00 AM'),
    _TimeOption(label: '09:30 AM'),
    _TimeOption(label: '10:00 AM', enabled: false),
    _TimeOption(label: '11:00 AM'),
    _TimeOption(label: '11:30 AM'),
    _TimeOption(label: '01:00 PM'),
  ];

  static const _reasonOptions = <String>[
    'Schedule conflict',
    'Need a different doctor availability',
    'Need more preparation time',
    'Personal emergency',
  ];

  String _selectedDate = _dateOptions[1].dateNumber;
  String _selectedTime = '11:30 AM';
  String? _selectedReason;
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: DashboardSectionTopBar(
        title: 'Reschedule Booking',
        leadingIcon: Icons.arrow_back_rounded,
        onLeadingTap: () => Navigator.of(context).maybePop(),
      ),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 448),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.xl,
              ),
              children: [
                _CurrentAppointmentCard(args: widget.args),
                const SizedBox(height: AppSpacing.lg),
                _SectionLabel(title: 'SELECT NEW DATE'),
                const SizedBox(height: AppSpacing.sm),
                SizedBox(
                  height: 84,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _dateOptions.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: AppSpacing.sm),
                    itemBuilder: (context, index) {
                      final item = _dateOptions[index];
                      final isSelected = _selectedDate == item.dateNumber;

                      return _DateOptionTile(
                        option: item,
                        isSelected: isSelected,
                        onTap: () {
                          setState(() {
                            _selectedDate = item.dateNumber;
                          });
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                _SectionLabel(title: 'AVAILABLE TIMES'),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: _timeOptions.map((item) {
                    final isSelected = _selectedTime == item.label;
                    return _TimeOptionTile(
                      option: item,
                      isSelected: isSelected,
                      onTap: item.enabled
                          ? () {
                              setState(() {
                                _selectedTime = item.label;
                              });
                            }
                          : null,
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSpacing.lg),
                _SectionLabel(title: 'REASON & DETAILS'),
                const SizedBox(height: AppSpacing.sm),
                DropdownButtonFormField<String>(
                  initialValue: _selectedReason,
                  decoration: const InputDecoration(
                    hintText: 'Select reason for change',
                    prefixIcon: Icon(
                      Icons.swap_horiz_rounded,
                      color: AppColors.outline,
                      size: 20,
                    ),
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.outline,
                  ),
                  items: _reasonOptions.map((reason) {
                    return DropdownMenuItem<String>(
                      value: reason,
                      child: Text(reason),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedReason = value;
                    });
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
                TextFormField(
                  controller: _notesController,
                  minLines: 4,
                  maxLines: 4,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: AppColors.onSurface),
                  decoration: const InputDecoration(
                    hintText: 'Additional notes for the clinic (optional)',
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.all(AppSpacing.md),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                AppSurfaceCard(
                  backgroundColor: AppColors.surfaceContainerLow,
                  borderColor: AppColors.surfaceContainerHigh,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.info_rounded,
                          color: AppColors.primary,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rescheduling Policy',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: AppColors.onSurface,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              'Changes made within 24 hours of the appointment may incur a small fee. Your current slot will be released once you confirm.',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: AppColors.onSurfaceVariant,
                                    height: 1.45,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                AppButton(
                  label: 'Confirm Reschedule',
                  onPressed: _selectedReason == null
                      ? null
                      : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Consultation moved to $_selectedTime on ${_selectedDayLabel()} $_selectedDate.',
                              ),
                            ),
                          );
                          Navigator.of(context).maybePop();
                        },
                ),
                const SizedBox(height: AppSpacing.sm),
                AppButton(
                  label: 'Cancel',
                  onPressed: () => Navigator.of(context).maybePop(),
                  variant: AppButtonVariant.outline,
                  foregroundColor: AppColors.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _selectedDayLabel() {
    return _dateOptions
        .firstWhere((item) => item.dateNumber == _selectedDate)
        .dayLabel;
  }
}

class _CurrentAppointmentCard extends StatelessWidget {
  const _CurrentAppointmentCard({required this.args});

  final RescheduleConsultationArgs args;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          Container(
            width: 4,
            height: 128,
            decoration: const BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(AppRadius.lg),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              args.doctor.name,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    color: AppColors.onSurface,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.medical_services_outlined,
                                  size: 16,
                                  color: AppColors.onSurfaceVariant,
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                Text(
                                  'Consultation',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: AppColors.onSurfaceVariant,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      AppPill(
                        label: args.statusLabel,
                        icon: Icons.verified_rounded,
                        backgroundColor: AppColors.primaryFixed.withValues(
                          alpha: 0.6,
                        ),
                        foregroundColor: AppColors.primaryContainer,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const Divider(
                    height: 0,
                    color: AppColors.surfaceContainerHigh,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: _AppointmentDetailItem(
                          icon: Icons.calendar_today_rounded,
                          label: 'Date & Time',
                          value:
                              '${args.currentDateLabel}, ${args.currentTimeLabel}',
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: _AppointmentDetailItem(
                          icon: Icons.videocam_rounded,
                          label: 'Type',
                          value: args.modeLabel,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AppointmentDetailItem extends StatelessWidget {
  const _AppointmentDetailItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return AppMetricTile(
      icon: icon,
      label: label,
      value: value,
      layout: AppMetricTileLayout.leading,
      padding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      borderColor: Colors.transparent,
      iconColor: AppColors.primary,
      iconSize: 16,
      iconBackgroundColor: AppColors.surfaceContainerLow,
      iconContainerSize: 36,
      iconContainerRadius: AppRadius.pill,
      labelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: AppColors.onSurfaceVariant,
        fontWeight: FontWeight.w600,
      ),
      valueStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: AppColors.onSurface,
        fontWeight: FontWeight.w700,
      ),
      labelValueSpacing: 2,
    );
  }
}

class _DateOptionTile extends StatelessWidget {
  const _DateOptionTile({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final _DateOption option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Ink(
        width: 68,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryFixed.withValues(alpha: 0.7)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryContainer
                : AppColors.outlineVariant,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              option.dayLabel,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              option.dateNumber,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: 18,
                color: isSelected
                    ? AppColors.primaryContainer
                    : AppColors.onSurface,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeOptionTile extends StatelessWidget {
  const _TimeOptionTile({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final _TimeOption option;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = !option.enabled
        ? AppColors.outlineVariant
        : isSelected
        ? AppColors.primaryContainer
        : AppColors.onSurface;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Ink(
        width: 118,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryFixed.withValues(alpha: 0.55)
              : option.enabled
              ? AppColors.surface
              : AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryContainer
                : AppColors.outlineVariant,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Text(
          option.label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: foregroundColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
        color: AppColors.primaryContainer,
        fontWeight: FontWeight.w800,
        letterSpacing: 1,
      ),
    );
  }
}

class _DateOption {
  const _DateOption({required this.dayLabel, required this.dateNumber});

  final String dayLabel;
  final String dateNumber;
}

class _TimeOption {
  const _TimeOption({required this.label, this.enabled = true});

  final String label;
  final bool enabled;
}
