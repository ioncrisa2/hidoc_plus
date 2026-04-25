import 'package:flutter/material.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_icon_circle_button.dart';
import '../../../../core/widgets/app_section_header.dart';
import '../../../../core/widgets/app_surface_card.dart';
import '../../../consultation/presentation/models/consultation_summary_args.dart';
import '../../../consultation/presentation/models/consultation_video_call_args.dart';
import '../../../doctors/presentation/models/doctor_mock_catalog.dart';
import 'dashboard_insight_card.dart';
import 'dashboard_quick_action_item.dart';

class DashboardHomeTab extends StatelessWidget {
  const DashboardHomeTab({super.key});

  static final _homeCallDoctor = DoctorMockCatalog.doctors.first;
  static final _recentConsultations = <_RecentConsultationItem>[
    _RecentConsultationItem(
      icon: Icons.monitor_heart_outlined,
      title: 'Cardiology Follow-up',
      date: 'Oct 24, 2023',
      summaryArgs: ConsultationSummaryArgs(
        doctor: DoctorMockCatalog.doctors.first,
        dateTimeLabel: 'Oct 24, 2023 • 10:30 AM',
        visitSummaryBullets: const [
          'Recorded blood pressure at 138/88 mmHg and classified it as mildly elevated.',
          'Patient reported intermittent heart palpitations during moderate activity.',
          'ECG findings during the session showed normal sinus rhythm.',
        ],
        outcomeMessage: 'No medicine was prescribed during this consultation.',
        recommendedActionTitle: 'Cardiac Stress Test',
        recommendedActionMessage:
            'To further evaluate the palpitations under controlled physical exertion, schedule a stress test with an estimated duration of 30-45 minutes.',
        primaryAction: ConsultationSummaryActionType.scheduleFollowUp,
        secondaryAction: ConsultationSummaryActionType.bookNewConsultation,
      ),
    ),
    _RecentConsultationItem(
      icon: Icons.local_hospital_outlined,
      title: 'Hypertension Review',
      date: 'Oct 22, 2023',
      summaryArgs: ConsultationSummaryArgs(
        doctor: DoctorMockCatalog.doctors.first,
        dateTimeLabel: 'Oct 24, 2023 • 10:30 AM',
        showFollowUpBadge: true,
        summaryOverview:
            'Patient presented with mild hypertension and persistent cough. Recent home blood pressure monitoring suggests Stage 1 hypertension.',
        visitSummaryBullets: const [
          'Primary diagnosis: essential hypertension.',
        ],
        diagnosisBullets: const [
          'Secondary diagnosis: acute upper respiratory infection.',
          'Recommended lifestyle: low sodium diet and light daily walking.',
        ],
        prescribedMedicines: const [
          ConsultationSummaryMedicine(
            name: 'Amoxicillin',
            dose: '500mg',
            schedule: 'Twice daily • 7 days',
            quantityLabel: 'Qty: 14 caps',
            icon: Icons.medication_rounded,
          ),
          ConsultationSummaryMedicine(
            name: 'Lisinopril',
            dose: '10mg',
            schedule: 'Once daily • 30 days',
            quantityLabel: 'Qty: 30 tabs',
            icon: Icons.vaccines_rounded,
            iconBackgroundColor: AppColors.secondaryContainer,
            iconColor: AppColors.secondary,
          ),
        ],
        prescriptionNotice:
            'Medicines prescribed after consultation require separate payment in Pharmacy. Insurance coverage may apply at checkout.',
        primaryAction: ConsultationSummaryActionType.orderMedicines,
        secondaryAction: ConsultationSummaryActionType.scheduleFollowUp,
      ),
    ),
  ];

  static const _quickActions = [
    (icon: Icons.medical_services_outlined, label: 'Consult'),
    (icon: Icons.description_outlined, label: 'Records'),
    (icon: Icons.medication_outlined, label: 'Medication'),
    (icon: Icons.health_and_safety_outlined, label: 'MCU'),
  ];

  static const _insights = [
    (
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBXdu9p_sTEguQOkI8UOHxZIdUNL_S44yTcVEX1To4Y4vlyg7wuiYj-BzmswBzPLgPhCXOxggwLDq3S7AfHFg6I7k-Do-vO_-XcJpORyqsy90nljF0-vgFMfo5EvxabXBEp8BXJ58yvd6AnGsG1H6Cyki96mP-F2Wpg4rTtV-Py4qjkRPsVuQEAyqMNYhCzYzviTeOK_HU4xvVkr7W4WLqmL0utHYRQfZ309kR5XVcYbnhTehtx6iaZgs43mhnK5i7eCRg5bvv9irg',
      badge: 'WELLNESS',
      badgeBg: AppColors.secondaryContainer,
      badgeFg: AppColors.secondary,
      title: '5 Tips for Better Sleep',
      subtitle: 'Improve your sleep hygiene with these simple steps.',
    ),
    (
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBgG5YLtFX54Z_HDS7nuXf3BHh0jF3DxydBbq1uqFOO-nCT5De2nhqFr9iCG51hUyMzDGBQAMIZvjV78symtZQiRXM91vkEMC4NtROJ-vL9UGDGtJSQtsvRIvtJOnlOgfE50VpYccC4E3dN7auzVEe_mWbqBKCwCws1KZQlVmodsziEFi5PwqDqLmNJI6bVpgUluhCP8XhRmY7EcMrJShQK4EvrTrZ90fhP5xvSlyH013aZYuKnzfVgsPKOnleoHCMiCbA3aGJwPfI',
      badge: 'NUTRITION',
      badgeBg: AppColors.primaryFixed,
      badgeFg: AppColors.primaryDark,
      title: 'Power Foods for Immunity',
      subtitle: 'Boost your immune system naturally this season.',
    ),
    (
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCL-_Mgs1_CUcmeImxKrY-Miqq6PPqe5tnGI3Mk-wrL4C0B7Iicj3uMoLEAEl__nfIlsCL7LY1QpRLN1P676TGNRKZujziw12qxxexIF4LVWOlmMtJ7R3NZQuTHouVQo_l4UyUmiz7tuzd_IFX_df_8GtnaH8inCfl5-_0vHBchlKpcROwB7Op4UR5Q0wueIIGpTeVs1sAxkNQ1hVO5GKrZ2FbWfywtsPj32bDcJrqRmk1d5w1iyh4t7CJofII6VKhyMt-VnTMwiZo',
      badge: 'MEDICAL',
      badgeBg: AppColors.surfaceContainerHighest,
      badgeFg: AppColors.tertiary,
      title: 'Understanding Blood Pressure',
      subtitle: 'What your numbers really mean for heart health.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md + 4,
        vertical: AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGreeting(context),
          const SizedBox(height: AppSpacing.md),
          _buildAppointmentHero(context),
          const SizedBox(height: AppSpacing.md),
          _buildQuickActions(context),
          const SizedBox(height: AppSpacing.lg - 4),
          _buildUpcomingAppointment(context),
          const SizedBox(height: AppSpacing.lg - 4),
          _buildPrescription(context),
          const SizedBox(height: AppSpacing.lg - 4),
          _buildRecentConsultations(context),
          const SizedBox(height: AppSpacing.lg - 4),
          _buildHealthInsights(),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }

  Widget _buildGreeting(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Good Morning, Elena',
              style: textTheme.headlineSmall?.copyWith(fontSize: 22),
            ),
            const SizedBox(width: AppSpacing.xs),
            const Icon(
              Icons.waving_hand_rounded,
              size: 20,
              color: AppColors.secondary,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text("Here's your health overview today.", style: textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildAppointmentHero(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.primaryContainer,
        borderRadius: BorderRadius.circular(AppRadius.xl - 4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.videocam_rounded, color: Colors.white70, size: 16),
                SizedBox(width: 6),
                Text(
                  'Consultation Ready',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '${_homeCallDoctor.name}\n10:30 AM Today',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                height: 1.3,
              ),
            ),
            const SizedBox(height: AppSpacing.sm + 2),
            SizedBox(
              width: 138,
              child: AppButton(
                label: 'Join Call',
                backgroundColor: AppColors.surface,
                foregroundColor: AppColors.primaryContainer,
                onPressed: () => _openVideoCall(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _quickActions.map((action) {
        return DashboardQuickActionItem(
          icon: action.icon,
          label: action.label,
          onTap: () {
            if (action.label == 'Consult') {
              Navigator.pushNamed(context, AppRoutes.consultationHub);
            }
          },
        );
      }).toList(),
    );
  }

  Widget _buildUpcomingAppointment(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppSectionHeader(
          title: 'Upcoming Appointments',
          actionLabel: 'See All',
        ),
        const SizedBox(height: AppSpacing.xs + 2),
        AppSurfaceCard(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.pill),
                child: Image.network(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuDK3iL-1vIYWZ-aO8dsCwLz1_mFs7fUydethKdi8XoX64YI_QlUDIVXsVWPLrQv9cosBhayD-6jDIj5acZOFOF6YrXT9wQfm3FRtpsEweGGn8E8LXMHiJGGdo3XrONC6qpde4W3KfahsnlHqdtCKQLyLsqbnBNYEzFANS0Yb4NckErg80gyDCDaLILDxfkldsGV9XIZTmTsmN3g7I0CT1JrNdZYIi6KhQLE5dnx1Co5bkyUyoW2bftmJ--tcfhszCbTk8hztCgA8Ho',
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _homeCallDoctor.name,
                      style: textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurface,
                      ),
                    ),
                    Text(
                      _homeCallDoctor.specialty,
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.xs,
                          vertical: 3,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.schedule_outlined,
                              size: 12,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Today, 10:30 AM',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AppIconCircleButton(
                icon: Icons.videocam_outlined,
                onTap: () => _openVideoCall(context),
                size: 34,
                iconSize: 18,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPrescription(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppSectionHeader(title: 'Prescriptions'),
        const SizedBox(height: AppSpacing.xs + 2),
        AppSurfaceCard(
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.secondaryContainer.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.medication_outlined,
                  color: AppColors.secondary,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Amoxicillin',
                      style: textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurface,
                      ),
                    ),
                    Text(
                      'Refill in 2 days',
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(onPressed: () {}, child: const Text('Refill')),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentConsultations(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppSectionHeader(title: 'Recent Consultations'),
        const SizedBox(height: AppSpacing.xs + 2),
        AppSurfaceCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: _recentConsultations.map((item) {
              final isLast = identical(item, _recentConsultations.last);

              return Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 4,
                    ),
                    leading: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        item.icon,
                        color: AppColors.onSurfaceVariant,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      item.title,
                      style: textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurface,
                      ),
                    ),
                    subtitle: Text(
                      item.date,
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: AppColors.outlineVariant,
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.consultationSummary,
                        arguments: item.summaryArgs,
                      );
                    },
                  ),
                  if (!isLast)
                    const Divider(
                      height: 0,
                      indent: 14,
                      endIndent: 14,
                      color: AppColors.surfaceContainerLow,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildHealthInsights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppSectionHeader(
          title: 'Health Insights',
          actionLabel: 'View All',
        ),
        const SizedBox(height: AppSpacing.xs + 2),
        ..._insights.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: DashboardInsightCard(
              imageUrl: item.imageUrl,
              badgeLabel: item.badge,
              badgeBackgroundColor: item.badgeBg,
              badgeForegroundColor: item.badgeFg,
              title: item.title,
              subtitle: item.subtitle,
              onTap: () {},
            ),
          );
        }),
      ],
    );
  }

  void _openVideoCall(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRoutes.consultationVideoCall,
      arguments: ConsultationVideoCallArgs(
        doctor: _homeCallDoctor,
        appointmentLabel: 'Today, 10:30 AM',
        sessionTimerLabel: '08:24',
        topicLabel: 'Heart rhythm review',
        note:
            'We are reviewing your recent ECG summary, chest discomfort episodes, and next medication adjustments.',
      ),
    );
  }
}

class _RecentConsultationItem {
  const _RecentConsultationItem({
    required this.icon,
    required this.title,
    required this.date,
    required this.summaryArgs,
  });

  final IconData icon;
  final String title;
  final String date;
  final ConsultationSummaryArgs summaryArgs;
}
