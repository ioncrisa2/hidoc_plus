import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/app_icon_circle_button.dart';
import '../../../../core/widgets/app_pill.dart';
import '../../../../core/widgets/app_section_card.dart';
import '../models/consultation_video_call_args.dart';

class ConsultationVideoCallScreen extends StatelessWidget {
  const ConsultationVideoCallScreen({super.key, required this.args});

  final ConsultationVideoCallArgs args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 448),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                AppSpacing.md,
              ),
              child: Column(
                children: [
                  _CallTopBar(args: args),
                  const SizedBox(height: AppSpacing.sm),
                  Expanded(child: _VideoStage(args: args)),
                  const SizedBox(height: AppSpacing.sm),
                  _CallControlPanel(args: args),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CallTopBar extends StatelessWidget {
  const _CallTopBar({required this.args});

  final ConsultationVideoCallArgs args;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        AppIconCircleButton(
          icon: Icons.arrow_back_rounded,
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.primary,
          onTap: () => Navigator.of(context).maybePop(),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Consultation in Progress',
                style: textTheme.titleLarge?.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${args.doctor.name} • ${args.appointmentLabel}',
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        AppPill(
          icon: Icons.schedule_rounded,
          label: args.sessionTimerLabel,
          backgroundColor: AppColors.primaryFixed,
          foregroundColor: AppColors.primaryContainer,
        ),
      ],
    );
  }
}

class _VideoStage extends StatelessWidget {
  const _VideoStage({required this.args});

  final ConsultationVideoCallArgs args;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: Stack(
        fit: StackFit.expand,
        children: [
          _DoctorStageBackground(imageUrl: args.doctor.imageUrl),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.inverseSurface.withValues(alpha: 0.62),
                    AppColors.primary.withValues(alpha: 0.24),
                    AppColors.inverseSurface.withValues(alpha: 0.84),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: AppSpacing.md,
            left: AppSpacing.md,
            child: Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                const _StageBadge(label: 'LIVE', showLiveDot: true),
                _StageBadge(
                  label: args.connectionLabel,
                  icon: Icons.shield_outlined,
                ),
              ],
            ),
          ),
          Positioned(
            top: AppSpacing.md,
            right: AppSpacing.md,
            child: _LocalPreviewCard(initials: args.patientInitials),
          ),
          Positioned(
            left: AppSpacing.md,
            right: AppSpacing.md,
            bottom: AppSpacing.md,
            child: _DoctorOverlayCard(args: args),
          ),
        ],
      ),
    );
  }
}

class _DoctorStageBackground extends StatelessWidget {
  const _DoctorStageBackground({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryContainer.withValues(alpha: 0.95),
                AppColors.inverseSurface,
              ],
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.videocam_rounded,
              size: 56,
              color: AppColors.inverseOnSurface,
            ),
          ),
        );
      },
    );
  }
}

class _StageBadge extends StatelessWidget {
  const _StageBadge({required this.label, this.icon, this.showLiveDot = false});

  final String label;
  final IconData? icon;
  final bool showLiveDot;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs - 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.inverseSurface.withValues(alpha: 0.76),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showLiveDot) ...[
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.secondaryContainer,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
          ] else if (icon != null) ...[
            Icon(icon, size: 14, color: AppColors.inverseOnSurface),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.inverseOnSurface,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _LocalPreviewCard extends StatelessWidget {
  const _LocalPreviewCard({required this.initials});

  final String initials;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 100,
      height: 132,
      padding: const EdgeInsets.all(AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppColors.inverseSurface.withValues(alpha: 0.36),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerHigh.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppAvatar(
              size: 40,
              initials: initials,
              radius: AppRadius.md,
              backgroundColor: AppColors.surface,
              foregroundColor: AppColors.primaryContainer,
              fallbackIcon: Icons.person_rounded,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'You',
              style: textTheme.labelMedium?.copyWith(
                color: AppColors.inverseOnSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Front camera',
              style: textTheme.labelSmall?.copyWith(
                color: AppColors.surfaceContainerHigh,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DoctorOverlayCard extends StatelessWidget {
  const _DoctorOverlayCard({required this.args});

  final ConsultationVideoCallArgs args;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: Colors.white.withValues(alpha: 0.72)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              AppAvatar(
                size: 42,
                imageUrl: args.doctor.imageUrl,
                radius: AppRadius.md,
                fallbackIcon: Icons.person_rounded,
              ),
              const SizedBox(width: AppSpacing.sm),
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
              const SizedBox(width: AppSpacing.xs),
              AppPill(
                label: args.statusLabel,
                backgroundColor: AppColors.secondaryContainer.withValues(
                  alpha: 0.22,
                ),
                foregroundColor: AppColors.secondary,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            args.topicLabel.toUpperCase(),
            style: textTheme.labelSmall?.copyWith(
              color: AppColors.primaryContainer,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.9,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            args.note,
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.onSurfaceVariant,
              height: 1.45,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _CallControlPanel extends StatelessWidget {
  const _CallControlPanel({required this.args});

  final ConsultationVideoCallArgs args;

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      title: 'Session Controls',
      titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: AppColors.onSurface,
        fontWeight: FontWeight.w700,
      ),
      action: AppPill(
        icon: Icons.wifi_tethering_rounded,
        label: 'Connection stable',
        backgroundColor: AppColors.primaryFixed.withValues(alpha: 0.72),
        foregroundColor: AppColors.primaryContainer,
      ),
      headerBottomSpacing: AppSpacing.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              AppPill(
                label: args.topicLabel,
                backgroundColor: AppColors.surfaceContainerLow,
                foregroundColor: AppColors.primaryContainer,
              ),
              AppPill(
                icon: Icons.calendar_today_outlined,
                label: args.appointmentLabel,
                backgroundColor: AppColors.surfaceContainerLow,
                foregroundColor: AppColors.onSurfaceVariant,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _CallControlButton(
                  icon: Icons.mic_none_rounded,
                  label: 'Mic',
                  onTap: () {},
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _CallControlButton(
                  icon: Icons.volume_up_rounded,
                  label: 'Audio',
                  onTap: () {},
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _CallControlButton(
                  icon: Icons.videocam_rounded,
                  label: 'Camera',
                  onTap: () {},
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _CallControlButton(
                  icon: Icons.call_end_rounded,
                  label: 'End',
                  backgroundColor: AppColors.errorContainer,
                  foregroundColor: AppColors.error,
                  onTap: () => Navigator.of(context).maybePop(),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.primaryFixed,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.description_outlined,
                    size: 16,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Clinical note preview',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: AppColors.onSurface,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'This session is focused on symptom review, medication response, and the next care plan after today\'s call.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
        ],
      ),
    );
  }
}

class _CallControlButton extends StatelessWidget {
  const _CallControlButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.backgroundColor = AppColors.surfaceContainerLow,
    this.foregroundColor = AppColors.primary,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(icon, size: 22, color: foregroundColor),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.onSurfaceVariant,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
