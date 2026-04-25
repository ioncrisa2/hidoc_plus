import 'package:flutter/material.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_pill.dart';
import '../../../../core/widgets/app_surface_card.dart';
import '../../../dashboard/presentation/widgets/dashboard_section_top_bar.dart';
import '../../../doctors/presentation/models/doctor_profile_data.dart';
import '../models/book_consultation_args.dart';
import '../models/booking_confirmation_args.dart';
import '../widgets/booking_payment_option_tile.dart';

class BookConsultationScreen extends StatefulWidget {
  const BookConsultationScreen({super.key, required this.args});

  final BookConsultationArgs args;

  @override
  State<BookConsultationScreen> createState() => _BookConsultationScreenState();
}

class _BookConsultationScreenState extends State<BookConsultationScreen> {
  static const _serviceFee = 2.0;
  String _selectedPaymentMethod = 'Credit / Debit Card';

  static const _paymentMethods = [
    (icon: Icons.credit_card_rounded, label: 'Credit / Debit Card'),
    (icon: Icons.account_balance_rounded, label: 'Bank Transfer'),
    (icon: Icons.account_balance_wallet_rounded, label: 'E-Wallet'),
  ];

  double get _consultationFee =>
      double.tryParse(widget.args.doctor.feeLabel.replaceAll('\$', '')) ?? 0;

  double get _totalAmount => _consultationFee + _serviceFee;

  @override
  Widget build(BuildContext context) {
    final bookingInfo = _buildBookingInfo(widget.args);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: DashboardSectionTopBar(
        title: 'Book Consultation',
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
                _DoctorBookingHeader(
                  doctor: widget.args.doctor,
                  modeLabel: bookingInfo.modeLabel,
                ),
                const SizedBox(height: AppSpacing.lg),
                AppSurfaceCard(
                  child: Row(
                    children: [
                      Expanded(
                        child: _BookingDetailCell(
                          label: 'DATE',
                          value: bookingInfo.dateLabel,
                        ),
                      ),
                      const _BookingDivider(),
                      Expanded(
                        child: _BookingDetailCell(
                          label: 'TIME',
                          value: bookingInfo.timeLabel,
                        ),
                      ),
                      const _BookingDivider(),
                      Expanded(
                        child: _BookingDetailCell(
                          label: 'MODE',
                          value: bookingInfo.modeShortLabel,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'Select Payment Method',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                AppSurfaceCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: List.generate(_paymentMethods.length, (index) {
                      final option = _paymentMethods[index];
                      final isLast = index == _paymentMethods.length - 1;

                      return Column(
                        children: [
                          BookingPaymentOptionTile(
                            icon: option.icon,
                            label: option.label,
                            isSelected: _selectedPaymentMethod == option.label,
                            onTap: () {
                              setState(() {
                                _selectedPaymentMethod = option.label;
                              });
                            },
                          ),
                          if (!isLast)
                            const Divider(
                              height: 0,
                              indent: AppSpacing.sm,
                              endIndent: AppSpacing.sm,
                              color: AppColors.surfaceContainerLow,
                            ),
                        ],
                      );
                    }),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                AppSurfaceCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payment Summary',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _SummaryRow(
                        label: 'Consultation Fee',
                        value: _formatCurrency(_consultationFee),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _SummaryRow(
                        label: 'Service Fee',
                        value: _formatCurrency(_serviceFee),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                        child: Divider(
                          height: 0,
                          color: AppColors.surfaceContainerHigh,
                        ),
                      ),
                      _SummaryRow(
                        label: 'Total Amount',
                        value: _formatCurrency(_totalAmount),
                        emphasize: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                AppButton(
                  label: 'Pay & Confirm Booking',
                  icon: Icons.lock_outline_rounded,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.consultationPaymentSuccess,
                      arguments: BookingConfirmationArgs(
                        doctor: widget.args.doctor,
                        dateLabel: bookingInfo.dateLabel,
                        timeLabel: bookingInfo.timeLabel,
                        durationLabel: widget.args.doctor.durationLabel,
                        modeLabel: bookingInfo.modeLabel,
                        paymentMethodLabel: _selectedPaymentMethod,
                        totalPaid: _totalAmount,
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'You are paying only for the consultation session. Medicines, if prescribed, will be paid separately later.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.onSurfaceVariant,
                    height: 1.45,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _BookingInfo _buildBookingInfo(BookConsultationArgs args) {
    final slotLabel =
        args.slotLabel ??
        (args.doctor.quickBookSlots.isNotEmpty
            ? args.doctor.quickBookSlots.first
            : args.doctor.nextAvailableLabel);

    final modeLabel =
        args.modeLabel ??
        (args.doctor.supportsVideoCall
            ? 'Video Consultation'
            : 'In-Clinic Consultation');

    if (slotLabel.contains(' - ')) {
      final parts = slotLabel.split(' - ');
      return _BookingInfo(
        dateLabel: parts.first,
        timeLabel: parts.sublist(1).join(' - '),
        modeLabel: modeLabel,
      );
    }

    if (slotLabel.contains(',')) {
      final parts = slotLabel.split(',');
      return _BookingInfo(
        dateLabel: parts.first.trim(),
        timeLabel: parts.sublist(1).join(',').trim(),
        modeLabel: modeLabel,
      );
    }

    return _BookingInfo(
      dateLabel: slotLabel,
      timeLabel: 'TBD',
      modeLabel: modeLabel,
    );
  }

  String _formatCurrency(double value) => '\$${value.toStringAsFixed(2)}';
}

class _DoctorBookingHeader extends StatelessWidget {
  const _DoctorBookingHeader({required this.doctor, required this.modeLabel});

  final DoctorProfileData doctor;
  final String modeLabel;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppAvatar(
            size: 64,
            imageUrl: doctor.imageUrl,
            radius: AppRadius.md,
            fallbackIcon: Icons.person_rounded,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  doctor.specialty,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.xs,
                  children: [
                    AppPill(
                      icon: Icons.videocam_rounded,
                      label: modeLabel.toUpperCase(),
                      backgroundColor: AppColors.secondaryContainer.withValues(
                        alpha: 0.2,
                      ),
                      foregroundColor: AppColors.secondary,
                      iconSize: 14,
                    ),
                    AppPill(
                      icon: Icons.schedule_rounded,
                      label: doctor.durationLabel,
                      backgroundColor: AppColors.surfaceContainerLow.withValues(
                        alpha: 0.2,
                      ),
                      foregroundColor: AppColors.onSurfaceVariant,
                      iconSize: 14,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingDetailCell extends StatelessWidget {
  const _BookingDetailCell({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.onSurfaceVariant,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingDivider extends StatelessWidget {
  const _BookingDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 56,
      color: AppColors.surfaceContainerHigh,
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.emphasize = false,
  });

  final String label;
  final String value;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final color = emphasize ? AppColors.primary : AppColors.onSurfaceVariant;
    final textStyle = emphasize
        ? Theme.of(context).textTheme.titleLarge
        : Theme.of(context).textTheme.bodyLarge;

    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: textStyle?.copyWith(
              color: emphasize
                  ? AppColors.onSurface
                  : AppColors.onSurfaceVariant,
              fontWeight: emphasize ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          style: textStyle?.copyWith(color: color, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class _BookingInfo {
  const _BookingInfo({
    required this.dateLabel,
    required this.timeLabel,
    required this.modeLabel,
  });

  final String dateLabel;
  final String timeLabel;
  final String modeLabel;

  String get modeShortLabel => modeLabel.replaceAll(' Consultation', '');
}
