import 'package:flutter/material.dart';

import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import 'app_pill.dart';

class AppStatusChip extends StatelessWidget {
  const AppStatusChip({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    this.radius = AppRadius.xs,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return AppPill(
      label: label,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      radius: radius,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs - 1,
        vertical: 2,
      ),
      letterSpacing: 0.5,
    );
  }
}
