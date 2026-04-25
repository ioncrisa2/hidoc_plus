import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';

class AppPill extends StatelessWidget {
  const AppPill({
    super.key,
    required this.label,
    this.icon,
    this.backgroundColor = AppColors.surfaceContainerLow,
    this.foregroundColor = AppColors.primary,
    this.borderColor,
    this.radius = AppRadius.pill,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.xs,
      vertical: 6,
    ),
    this.iconSize = 14,
    this.gap = 4,
    this.fontSize,
    this.fontWeight = FontWeight.w700,
    this.letterSpacing,
  });

  final String label;
  final IconData? icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final double radius;
  final EdgeInsetsGeometry padding;
  final double iconSize;
  final double gap;
  final double? fontSize;
  final FontWeight fontWeight;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: borderColor == null ? null : Border.all(color: borderColor!),
      ),
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: iconSize, color: foregroundColor),
              SizedBox(width: gap),
            ],
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: foregroundColor,
                fontWeight: fontWeight,
                fontSize: fontSize,
                letterSpacing: letterSpacing,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
