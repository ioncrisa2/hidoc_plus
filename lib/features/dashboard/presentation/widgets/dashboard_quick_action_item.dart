import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_surface_card.dart';

class DashboardQuickActionItem extends StatelessWidget {
  const DashboardQuickActionItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AppSurfaceCard(
            padding: EdgeInsets.zero,
            radius: AppRadius.lg,
            child: SizedBox(
              width: 56,
              height: 56,
              child: Icon(icon, color: AppColors.primary, size: 26),
            ),
          ),
          const SizedBox(height: AppSpacing.xxs + 1),
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              color: AppColors.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
