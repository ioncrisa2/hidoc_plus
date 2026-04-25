import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_avatar.dart';

class ConsultationRecentMessageTile extends StatelessWidget {
  const ConsultationRecentMessageTile({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.message,
    required this.timeLabel,
    required this.onTap,
  });

  final String imageUrl;
  final String name;
  final String message;
  final String timeLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xxs,
      ),
      leading: AppAvatar(
        size: 44,
        imageUrl: imageUrl,
        radius: AppRadius.md,
        fallbackIcon: Icons.person_rounded,
      ),
      title: Text(
        name,
        style: textTheme.labelMedium?.copyWith(
          color: AppColors.onSurface,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        message,
        style: textTheme.labelSmall?.copyWith(
          color: AppColors.onSurfaceVariant,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        timeLabel,
        style: textTheme.labelSmall?.copyWith(
          color: AppColors.outline,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
