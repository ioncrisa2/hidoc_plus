import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/app_surface_card.dart';

class ConsultationActiveSessionCard extends StatelessWidget {
  const ConsultationActiveSessionCard({
    super.key,
    required this.imageUrl,
    required this.doctorName,
    required this.specialty,
    required this.onStartVideoCall,
  });

  final String imageUrl;
  final String doctorName;
  final String specialty;
  final VoidCallback onStartVideoCall;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppSurfaceCard(
      child: Row(
        children: [
          AppAvatar(
            size: 54,
            imageUrl: imageUrl,
            radius: AppRadius.md,
            fallbackIcon: Icons.person_rounded,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorName,
                  style: textTheme.labelMedium?.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  specialty,
                  style: textTheme.labelSmall?.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                SizedBox(
                  height: 36,
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: onStartVideoCall,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primaryContainer,
                      foregroundColor: AppColors.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                    ),
                    icon: const Icon(Icons.videocam_rounded, size: 16),
                    label: const Text('Start Video Call'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
