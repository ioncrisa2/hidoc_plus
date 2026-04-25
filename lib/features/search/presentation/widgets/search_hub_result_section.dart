import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_section_card.dart';

class SearchHubResultSection extends StatelessWidget {
  const SearchHubResultSection({
    super.key,
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.children,
  });

  final IconData icon;
  final String title;
  final Color iconColor;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppSectionCard(
      radius: AppRadius.lg,
      headerBottomSpacing: AppSpacing.sm,
      header: Row(
        children: [
          Icon(icon, size: 14, color: iconColor),
          const SizedBox(width: AppSpacing.xxs),
          Text(
            title,
            style: textTheme.labelSmall?.copyWith(
              color: iconColor,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
