import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_list_row.dart';
import '../../../../core/widgets/app_surface_card.dart';

class DashboardProfileMenuSection extends StatelessWidget {
  const DashboardProfileMenuSection({
    super.key,
    required this.title,
    required this.items,
  });

  final String title;
  final List<DashboardProfileMenuItemData> items;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.labelSmall?.copyWith(
            color: AppColors.outline,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        AppSurfaceCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isLast = index == items.length - 1;

              return Column(
                children: [
                  _DashboardProfileMenuTile(item: item),
                  if (!isLast)
                    const Divider(
                      height: 0,
                      indent: 16,
                      endIndent: 16,
                      color: AppColors.surfaceContainerLow,
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}

class DashboardProfileMenuItemData {
  const DashboardProfileMenuItemData({
    required this.icon,
    required this.title,
    this.trailingLabel,
  });

  final IconData icon;
  final String title;
  final String? trailingLabel;
}

class _DashboardProfileMenuTile extends StatelessWidget {
  const _DashboardProfileMenuTile({required this.item});

  final DashboardProfileMenuItemData item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppListRow(
      onTap: () {},
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 14,
      ),
      leading: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Icon(item.icon, size: 18, color: AppColors.primary),
      ),
      title: Text(
        item.title,
        style: textTheme.labelMedium?.copyWith(
          color: AppColors.onSurface,
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.trailingLabel != null) ...[
            Text(
              item.trailingLabel!,
              style: textTheme.labelSmall?.copyWith(
                color: AppColors.outline,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
          ],
          const Icon(
            Icons.chevron_right_rounded,
            size: 18,
            color: AppColors.outline,
          ),
        ],
      ),
    );
  }
}
