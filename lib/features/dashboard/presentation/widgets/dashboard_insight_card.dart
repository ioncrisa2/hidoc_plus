import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_status_chip.dart';
import '../../../../core/widgets/app_surface_card.dart';

class DashboardInsightCard extends StatelessWidget {
  const DashboardInsightCard({
    super.key,
    required this.imageUrl,
    required this.badgeLabel,
    required this.badgeBackgroundColor,
    required this.badgeForegroundColor,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final String imageUrl;
  final String badgeLabel;
  final Color badgeBackgroundColor;
  final Color badgeForegroundColor;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: AppSurfaceCard(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: Image.network(
                imageUrl,
                width: 68,
                height: 68,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 68,
                    height: 68,
                    color: AppColors.surfaceContainer,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      color: AppColors.outline,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppStatusChip(
                    label: badgeLabel,
                    backgroundColor: badgeBackgroundColor,
                    foregroundColor: badgeForegroundColor,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    title,
                    style: textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: textTheme.labelSmall?.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
