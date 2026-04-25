import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import 'app_button.dart';

Future<bool?> showAppConfirmationDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  String cancelLabel = 'Cancel',
  IconData icon = Icons.help_outline_rounded,
  Color iconBackgroundColor = AppColors.primaryFixed,
  Color iconColor = AppColors.primary,
  Color confirmBackgroundColor = AppColors.primaryContainer,
  Color confirmForegroundColor = AppColors.onPrimary,
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AppConfirmationDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        icon: icon,
        iconBackgroundColor: iconBackgroundColor,
        iconColor: iconColor,
        confirmBackgroundColor: confirmBackgroundColor,
        confirmForegroundColor: confirmForegroundColor,
      );
    },
  );
}

class AppConfirmationDialog extends StatelessWidget {
  const AppConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.cancelLabel,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconColor,
    required this.confirmBackgroundColor,
    required this.confirmForegroundColor,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final IconData icon;
  final Color iconBackgroundColor;
  final Color iconColor;
  final Color confirmBackgroundColor;
  final Color confirmForegroundColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Dialog(
      backgroundColor: AppColors.surface,
      insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 26),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              style: textTheme.titleLarge?.copyWith(color: AppColors.onSurface),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              message,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.onSurfaceVariant,
                height: 1.45,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: cancelLabel,
                    onPressed: () => Navigator.of(context).pop(false),
                    variant: AppButtonVariant.outline,
                    height: 46,
                    foregroundColor: AppColors.onSurface,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: AppButton(
                    label: confirmLabel,
                    onPressed: () => Navigator.of(context).pop(true),
                    height: 46,
                    backgroundColor: confirmBackgroundColor,
                    foregroundColor: confirmForegroundColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
