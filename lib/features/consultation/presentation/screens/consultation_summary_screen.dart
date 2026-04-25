import 'package:flutter/material.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_list_row.dart';
import '../../../../core/widgets/app_pill.dart';
import '../../../../core/widgets/app_section_card.dart';
import '../../../dashboard/presentation/widgets/dashboard_section_top_bar.dart';
import '../../presentation/models/book_consultation_args.dart';
import '../models/consultation_summary_args.dart';

class ConsultationSummaryScreen extends StatelessWidget {
  const ConsultationSummaryScreen({super.key, required this.args});

  final ConsultationSummaryArgs args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: DashboardSectionTopBar(
        title: 'Consultation Summary',
        leadingIcon: Icons.arrow_back_rounded,
        trailingIcon: Icons.more_vert_rounded,
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
                _SummaryHeaderCard(args: args),
                const SizedBox(height: AppSpacing.md),
                _SummarySectionCard(
                  icon: Icons.assignment_rounded,
                  title: 'VISIT SUMMARY',
                  child: _VisitSummaryContent(args: args),
                ),
                const SizedBox(height: AppSpacing.md),
                if (args.prescribedMedicines.isEmpty) ...[
                  _SummarySectionCard(
                    icon: Icons.info_rounded,
                    title: 'OUTCOME',
                    backgroundColor: AppColors.surfaceContainerLow,
                    child: _OutcomeContent(message: args.outcomeMessage),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  if (args.recommendedActionTitle != null &&
                      args.recommendedActionMessage != null)
                    _SummarySectionCard(
                      icon: Icons.recommend_rounded,
                      title: 'RECOMMENDED ACTION',
                      backgroundColor: AppColors.secondaryContainer.withValues(
                        alpha: 0.18,
                      ),
                      borderColor: AppColors.secondaryContainer.withValues(
                        alpha: 0.34,
                      ),
                      child: _RecommendedActionContent(
                        title: args.recommendedActionTitle!,
                        message: args.recommendedActionMessage!,
                      ),
                    ),
                ] else ...[
                  _SummarySectionCard(
                    icon: Icons.medication_rounded,
                    title: 'PRESCRIBED MEDICINES',
                    action: AppPill(
                      label: '${args.prescribedMedicines.length} items',
                      backgroundColor: AppColors.secondaryContainer.withValues(
                        alpha: 0.22,
                      ),
                      foregroundColor: AppColors.secondary,
                    ),
                    child: _PrescribedMedicinesContent(
                      medicines: args.prescribedMedicines,
                    ),
                  ),
                  if (args.prescriptionNotice != null) ...[
                    const SizedBox(height: AppSpacing.md),
                    _PrescriptionNoticeCard(message: args.prescriptionNotice!),
                  ],
                ],
                const SizedBox(height: AppSpacing.lg),
                AppButton(
                  label: args.primaryAction.label,
                  icon: args.primaryAction.icon,
                  iconTrailing: false,
                  onPressed: () => _handleAction(context, args.primaryAction),
                ),
                const SizedBox(height: AppSpacing.sm),
                AppButton(
                  label: args.secondaryAction.label,
                  icon: args.secondaryAction.icon,
                  iconTrailing: false,
                  variant: AppButtonVariant.outline,
                  onPressed: () => _handleAction(context, args.secondaryAction),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleAction(
    BuildContext context,
    ConsultationSummaryActionType action,
  ) {
    switch (action) {
      case ConsultationSummaryActionType.scheduleFollowUp:
      case ConsultationSummaryActionType.bookNewConsultation:
        Navigator.pushNamed(
          context,
          AppRoutes.bookConsultation,
          arguments: BookConsultationArgs(
            doctor: args.doctor,
            slotLabel: args.doctor.nextAvailableLabel,
          ),
        );
      case ConsultationSummaryActionType.orderMedicines:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pharmacy ordering flow will be connected here.'),
          ),
        );
    }
  }
}

class _SummaryHeaderCard extends StatelessWidget {
  const _SummaryHeaderCard({required this.args});

  final ConsultationSummaryArgs args;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.surfaceContainerHighest),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppAvatar(
            size: 58,
            imageUrl: args.doctor.imageUrl,
            radius: AppRadius.md,
            fallbackIcon: Icons.person_rounded,
            badge: const AppAvatarBadge(),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
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
                            style: textTheme.titleMedium?.copyWith(
                              color: AppColors.onSurface,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            args.doctor.specialty,
                            style: textTheme.bodySmall?.copyWith(
                              color: AppColors.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (args.showFollowUpBadge) ...[
                      const SizedBox(width: AppSpacing.xs),
                      AppPill(
                        label: 'FOLLOW-UP',
                        backgroundColor: AppColors.secondaryContainer
                            .withValues(alpha: 0.2),
                        foregroundColor: AppColors.secondary,
                        fontSize: 10.5,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.xs,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _MetaItem(
                      icon: Icons.star_rounded,
                      label:
                          '${args.doctor.rating.toStringAsFixed(1)}  ${args.doctor.reviewCount}+ reviews',
                    ),
                    _MetaItem(
                      icon: Icons.event_available_rounded,
                      label: args.dateTimeLabel,
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

class _SummarySectionCard extends StatelessWidget {
  const _SummarySectionCard({
    required this.icon,
    required this.title,
    required this.child,
    this.action,
    this.backgroundColor = AppColors.surface,
    this.borderColor = AppColors.surfaceContainerHighest,
  });

  final IconData icon;
  final String title;
  final Widget child;
  final Widget? action;
  final Color backgroundColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      action: action,
      headerBottomSpacing: AppSpacing.sm,
      header: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.primaryFixed.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 14, color: AppColors.primary),
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.onSurfaceVariant,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
          ),
          if (action case final Widget sectionAction) sectionAction,
        ],
      ),
      child: child,
    );
  }
}

class _VisitSummaryContent extends StatelessWidget {
  const _VisitSummaryContent({required this.args});

  final ConsultationSummaryArgs args;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (args.summaryOverview != null) ...[
          Text(
            args.summaryOverview!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.onSurfaceVariant,
              height: 1.45,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        ...args.visitSummaryBullets.map(
          (point) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: _BulletLine(text: point),
          ),
        ),
        if (args.diagnosisBullets.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xs),
          ...args.diagnosisBullets.map(
            (point) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: _BulletLine(text: point),
            ),
          ),
        ],
      ],
    );
  }
}

class _OutcomeContent extends StatelessWidget {
  const _OutcomeContent({required this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              color: AppColors.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.info_rounded,
              size: 12,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message ?? 'No additional outcome was recorded for this visit.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.onSurfaceVariant,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecommendedActionContent extends StatelessWidget {
  const _RecommendedActionContent({required this.title, required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.onSurfaceVariant,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrescribedMedicinesContent extends StatelessWidget {
  const _PrescribedMedicinesContent({required this.medicines});

  final List<ConsultationSummaryMedicine> medicines;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(medicines.length, (index) {
        final item = medicines[index];
        final isLast = index == medicines.length - 1;

        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.sm),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.surfaceContainerHighest),
            ),
            child: AppListRow(
              minHeight: 0,
              padding: const EdgeInsets.all(AppSpacing.sm),
              leading: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color:
                      item.iconBackgroundColor ??
                      AppColors.primaryFixed.withValues(alpha: 0.72),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                alignment: Alignment.center,
                child: Icon(
                  item.icon,
                  size: 18,
                  color: item.iconColor ?? AppColors.primary,
                ),
              ),
              title: Text(
                '${item.name} ${item.dose}',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w800,
                ),
              ),
              subtitleSpacing: 4,
              subtitle: Text(
                '${item.schedule} • ${item.quantityLabel}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _PrescriptionNoticeCard extends StatelessWidget {
  const _PrescriptionNoticeCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.surfaceContainerHighest),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: AppColors.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.info_rounded,
              size: 14,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.onSurfaceVariant,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletLine extends StatelessWidget {
  const _BulletLine({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Container(
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              color: AppColors.secondary,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.onSurfaceVariant,
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: AppColors.primary),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppColors.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
