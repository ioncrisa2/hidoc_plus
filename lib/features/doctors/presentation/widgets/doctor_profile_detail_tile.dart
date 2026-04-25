import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/widgets/app_metric_tile.dart';

class DoctorProfileDetailTile extends StatelessWidget {
  const DoctorProfileDetailTile({
    super.key,
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
      iconColor: AppColors.primary,
      backgroundColor: AppColors.surfaceContainerLow,
      borderColor: AppColors.surfaceContainerLow,
      radius: AppRadius.md,
      fillVerticalSpace: true,
      labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: AppColors.onSurfaceVariant,
        fontWeight: FontWeight.w500,
      ),
      valueStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: AppColors.onSurface,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
