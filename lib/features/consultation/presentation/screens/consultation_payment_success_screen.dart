import 'package:flutter/material.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_metric_tile.dart';
import '../../../../core/widgets/app_pill.dart';
import '../../../../core/widgets/app_surface_card.dart';
import '../../../dashboard/presentation/widgets/dashboard_section_top_bar.dart';
import '../models/booking_confirmation_args.dart';

class ConsultationPaymentSuccessScreen extends StatelessWidget {
  const ConsultationPaymentSuccessScreen({super.key, required this.args});

  final BookingConfirmationArgs args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: DashboardSectionTopBar(
        title: 'Confirmation',
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
                AppSpacing.xs,
                AppSpacing.md,
                AppSpacing.lg,
              ),
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFDDF6F3), Color(0xFFF2F1FF)],
                    ),
                    border: Border.all(color: AppColors.surfaceContainerHigh),
                  ),
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.lg,
                    AppSpacing.md,
                    AppSpacing.md,
                  ),
                  child: Column(
                    children: [
                      const _SuccessBadge(),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'Consultation Confirmed',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.primaryContainer,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Your consultation with ${args.doctor.name} has been successfully booked.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.onSurfaceVariant,
                          height: 1.45,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _DoctorSummaryCard(args: args),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                AppSurfaceCard(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _DetailItem(
                              icon: Icons.calendar_today_rounded,
                              label: 'DATE',
                              value: args.dateLabel,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: _DetailItem(
                              icon: Icons.access_time_filled_rounded,
                              label: 'TIME',
                              value: args.timeLabel,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          Expanded(
                            child: _DetailItem(
                              icon: Icons.timelapse_rounded,
                              label: 'DURATION',
                              value: args.durationLabel,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: _DetailItem(
                              icon: Icons.wifi_tethering_rounded,
                              label: 'MODE',
                              value: _displayMode(args.modeLabel),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                AppSurfaceCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Payment Method',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.credit_card_rounded,
                              size: 16,
                              color: AppColors.onSurfaceVariant,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Flexible(
                              child: Text(
                                _paymentLabel(args.paymentMethodLabel),
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: AppColors.onSurfaceVariant,
                                    ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 0,
                        color: AppColors.surfaceContainerHigh,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Total Paid',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const Spacer(),
                            Text(
                              _formatCurrency(args.totalPaid),
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    color: AppColors.primaryContainer,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                AppSurfaceCard(
                  padding: const EdgeInsets.all(AppSpacing.md),
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
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Next Steps',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: AppColors.primaryContainer,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'You can join the consultation at the scheduled time. If medicine is prescribed after the session, payment for medicine will be handled separately in Pharmacy.',
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
                const SizedBox(height: AppSpacing.lg),
                AppButton(
                  label: 'View Appointment',
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.consultationHub,
                      (route) => route.settings.name == AppRoutes.dashboard,
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
                AppButton(
                  label: 'Back to Home',
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.dashboard,
                      (route) => false,
                    );
                  },
                  variant: AppButtonVariant.outline,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static String _displayMode(String modeLabel) {
    return modeLabel.replaceAll(' Consultation', '');
  }

  static String _paymentLabel(String paymentMethodLabel) {
    switch (paymentMethodLabel) {
      case 'Credit / Debit Card':
        return 'Visa **** 1234';
      case 'Bank Transfer':
        return 'Bank Transfer';
      case 'E-Wallet':
        return 'E-Wallet';
      default:
        return paymentMethodLabel;
    }
  }

  static String _formatCurrency(double value) =>
      '\$${value.toStringAsFixed(2)}';
}

class _SuccessBadge extends StatelessWidget {
  const _SuccessBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.52),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      alignment: Alignment.center,
      child: Container(
        width: 38,
        height: 38,
        decoration: const BoxDecoration(
          color: AppColors.secondaryContainer,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.check_rounded,
          color: AppColors.secondary,
          size: 24,
        ),
      ),
    );
  }
}

class _DoctorSummaryCard extends StatelessWidget {
  const _DoctorSummaryCard({required this.args});

  final BookingConfirmationArgs args;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Row(
        children: [
          AppAvatar(
            size: 60,
            imageUrl: args.doctor.imageUrl,
            radius: AppRadius.md,
            fallbackIcon: Icons.person_rounded,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  args.doctor.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  args.doctor.specialty,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          AppPill(
            icon: Icons.videocam_rounded,
            label: _isVideoMode(args.modeLabel) ? 'VIDEO' : 'VISIT',
            backgroundColor: AppColors.secondaryContainer.withValues(
              alpha: 0.22,
            ),
            foregroundColor: AppColors.secondary,
            radius: AppRadius.sm,
            iconSize: 12,
            gap: 3,
            fontSize: 10.5,
          ),
        ],
      ),
    );
  }

  bool _isVideoMode(String modeLabel) {
    return modeLabel.toLowerCase().contains('video') ||
        modeLabel.toLowerCase().contains('online');
  }
}

class _DetailItem extends StatelessWidget {
  const _DetailItem({
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
      iconSize: 14,
      iconBackgroundColor: AppColors.primaryFixed.withValues(alpha: 0.55),
      iconContainerSize: 28,
      iconContainerRadius: AppRadius.sm,
      labelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: AppColors.onSurfaceVariant,
        fontWeight: FontWeight.w700,
        fontSize: 11,
      ),
      valueStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: AppColors.onSurface,
        fontWeight: FontWeight.w700,
      ),
      labelValueSpacing: 2,
    );
  }
}
