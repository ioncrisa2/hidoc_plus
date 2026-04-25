import 'package:flutter/material.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_confirmation_dialog.dart';
import 'dashboard_profile_menu_section.dart';
import 'dashboard_profile_metric_card.dart';

class DashboardProfileTab extends StatelessWidget {
  const DashboardProfileTab({super.key});

  static const _personalItems = [
    DashboardProfileMenuItemData(
      icon: Icons.person_outline_rounded,
      title: 'Personal Information',
    ),
    DashboardProfileMenuItemData(
      icon: Icons.lock_outline_rounded,
      title: 'Security',
    ),
    DashboardProfileMenuItemData(
      icon: Icons.notifications_none_rounded,
      title: 'Notifications',
    ),
  ];

  static const _medicalItems = [
    DashboardProfileMenuItemData(
      icon: Icons.medical_information_outlined,
      title: 'Medical Profile',
    ),
    DashboardProfileMenuItemData(
      icon: Icons.science_outlined,
      title: 'Lab Results',
    ),
    DashboardProfileMenuItemData(
      icon: Icons.devices_other_outlined,
      title: 'Linked Devices',
    ),
  ];

  static const _preferenceItems = [
    DashboardProfileMenuItemData(
      icon: Icons.language_rounded,
      title: 'Language',
      trailingLabel: 'English',
    ),
    DashboardProfileMenuItemData(
      icon: Icons.help_outline_rounded,
      title: 'Help Center',
    ),
    DashboardProfileMenuItemData(
      icon: Icons.description_outlined,
      title: 'Terms & Conditions',
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
        children: [
          _buildHeader(context, textTheme),
          const SizedBox(height: AppSpacing.md),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: AppSpacing.sm,
            crossAxisSpacing: AppSpacing.sm,
            childAspectRatio: 1.95,
            children: const [
              DashboardProfileMetricCard(
                icon: Icons.water_drop_outlined,
                label: 'Blood Type',
                value: 'O+',
                iconColor: AppColors.primary,
              ),
              DashboardProfileMetricCard(
                icon: Icons.height_rounded,
                label: 'Height',
                value: '168 cm',
                iconColor: AppColors.primary,
              ),
              DashboardProfileMetricCard(
                icon: Icons.monitor_weight_outlined,
                label: 'Weight',
                value: '62 kg',
                iconColor: AppColors.primary,
              ),
              DashboardProfileMetricCard(
                icon: Icons.coronavirus_outlined,
                label: 'Allergy',
                value: 'Penicillin',
                iconColor: AppColors.error,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const DashboardProfileMenuSection(
            title: 'PERSONAL',
            items: _personalItems,
          ),
          const SizedBox(height: AppSpacing.md),
          const DashboardProfileMenuSection(
            title: 'MEDICAL',
            items: _medicalItems,
          ),
          const SizedBox(height: AppSpacing.md),
          const DashboardProfileMenuSection(
            title: 'PREFERENCES',
            items: _preferenceItems,
          ),
          const SizedBox(height: AppSpacing.lg),
          TextButton.icon(
            onPressed: () async {
              final confirmed = await showAppConfirmationDialog(
                context,
                title: 'Log out from HiDoc+?',
                message:
                    'You will need to sign in again to access your consultations, records, and services.',
                confirmLabel: 'Log Out',
                cancelLabel: 'Stay Here',
                icon: Icons.logout_rounded,
                iconBackgroundColor: AppColors.errorContainer,
                iconColor: AppColors.error,
                confirmBackgroundColor: AppColors.error,
                confirmForegroundColor: AppColors.onError,
              );

              if (confirmed == true && context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.login,
                  (route) => false,
                );
              }
            },
            icon: const Icon(
              Icons.logout_rounded,
              size: 18,
              color: AppColors.error,
            ),
            label: Text(
              'Log Out',
              style: textTheme.labelMedium?.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.w700,
              ),
            ),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, TextTheme textTheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.xl),
              child: Image.network(
                'https://randomuser.me/api/portraits/women/44.jpg',
                width: 72,
                height: 72,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainer,
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.person,
                      size: 30,
                      color: AppColors.primary,
                    ),
                  );
                },
              ),
            ),
            Positioned(
              right: -2,
              bottom: -2,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.background, width: 2),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  size: 13,
                  color: AppColors.onSecondary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Elena Rodriguez',
                  style: textTheme.titleLarge?.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Verified Member',
                  style: textTheme.labelMedium?.copyWith(
                    color: AppColors.outline,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryContainer.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.check_circle_rounded,
                        size: 12,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Account verified',
                        style: textTheme.labelSmall?.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        OutlinedButton.icon(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(0, 36),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            side: BorderSide(
              color: AppColors.outlineVariant.withValues(alpha: 0.8),
            ),
            foregroundColor: AppColors.outline,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            backgroundColor: AppColors.surface.withValues(alpha: 0.55),
          ),
          icon: const Icon(Icons.edit_outlined, size: 14),
          label: const Text('Edit'),
        ),
      ],
    );
  }
}
