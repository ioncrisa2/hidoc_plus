import 'package:flutter/material.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_section_header.dart';
import 'dashboard_continue_card.dart';
import 'dashboard_service_card.dart';

class DashboardServicesTab extends StatelessWidget {
  const DashboardServicesTab({super.key});

  static const _serviceCards = [
    (
      icon: Icons.medical_services_outlined,
      title: 'Consult',
      description: 'Book appointments and connect with doctors.',
      iconBg: AppColors.primaryFixed,
      accent: AppColors.primary,
    ),
    (
      icon: Icons.monitor_heart_outlined,
      title: 'MCU',
      description: 'Schedule check-ups and view results.',
      iconBg: AppColors.secondaryContainer,
      accent: AppColors.secondary,
    ),
    (
      icon: Icons.medication_outlined,
      title: 'Pharmacy',
      description: 'Order medicines and manage prescriptions.',
      iconBg: AppColors.surfaceContainerHigh,
      accent: AppColors.primary,
    ),
    (
      icon: Icons.folder_open_outlined,
      title: 'Medical Records',
      description: 'Access prescriptions, lab results, and health data.',
      iconBg: AppColors.primaryFixed,
      accent: AppColors.primary,
    ),
  ];

  static const _continueItems = [
    (
      icon: Icons.calendar_month_outlined,
      title: 'Upcoming Consultation',
      subtitle: 'Tomorrow, 10:30 AM',
      iconBg: AppColors.primaryFixed,
      iconColor: AppColors.primary,
    ),
    (
      icon: Icons.assignment_outlined,
      title: 'Pending MCU Booking',
      subtitle: 'Complete your booking details',
      iconBg: AppColors.secondaryContainer,
      iconColor: AppColors.secondary,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Explore Services',
            style: textTheme.headlineSmall?.copyWith(fontSize: 20),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Access your essential healthcare services in one place.',
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.lg),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _serviceCards.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppSpacing.sm,
              crossAxisSpacing: AppSpacing.sm,
              childAspectRatio: 1.04,
            ),
            itemBuilder: (context, index) {
              final item = _serviceCards[index];

              return DashboardServiceCard(
                icon: item.icon,
                title: item.title,
                description: item.description,
                iconBackgroundColor: item.iconBg,
                accentColor: item.accent,
                onTap: () {
                  if (item.title == 'Consult') {
                    Navigator.pushNamed(context, AppRoutes.consultationHub);
                    return;
                  }
                },
              );
            },
          ),
          const SizedBox(height: AppSpacing.xl),
          const AppSectionHeader(title: 'Continue Where You Left Off'),
          const SizedBox(height: AppSpacing.sm),
          ..._continueItems.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: DashboardContinueCard(
                icon: item.icon,
                title: item.title,
                subtitle: item.subtitle,
                iconBackgroundColor: item.iconBg,
                iconColor: item.iconColor,
                onTap: () {
                  if (item.title == 'Upcoming Consultation') {
                    Navigator.pushNamed(context, AppRoutes.consultationHub);
                    return;
                  }
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
