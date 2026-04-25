import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_surface_card.dart';

class ConsultationDoctorCard extends StatelessWidget {
  const ConsultationDoctorCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.specialty,
    required this.onBook,
  });

  final String imageUrl;
  final String name;
  final String specialty;
  final VoidCallback onBook;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppSurfaceCard(
      child: Column(
        children: [
          AppAvatar(
            size: 72,
            imageUrl: imageUrl,
            radius: AppRadius.md,
            fallbackIcon: Icons.person_rounded,
            badge: const AppAvatarBadge(),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            name,
            style: textTheme.labelMedium?.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            specialty,
            style: textTheme.labelSmall?.copyWith(
              color: AppColors.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: 'Book',
            onPressed: onBook,
            variant: AppButtonVariant.tonal,
            size: AppButtonSize.compact,
            height: 34,
          ),
        ],
      ),
    );
  }
}
