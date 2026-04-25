import 'package:flutter/material.dart';

import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';

class AppListRow extends StatelessWidget {
  const AppListRow({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.titleTrailing,
    this.onTap,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.gap = AppSpacing.sm,
    this.subtitleSpacing = 2,
    this.minHeight = 48,
    this.borderRadius = AppRadius.lg,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final Widget? titleTrailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final double gap;
  final double subtitleSpacing;
  final double minHeight;
  final double borderRadius;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: padding,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: Row(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            if (leading != null) ...[leading!, SizedBox(width: gap)],
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: title),
                      if (titleTrailing != null) ...[
                        const SizedBox(width: AppSpacing.xs),
                        titleTrailing!,
                      ],
                    ],
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: subtitleSpacing),
                    subtitle!,
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: AppSpacing.xs),
              trailing!,
            ],
          ],
        ),
      ),
    );

    if (onTap == null) {
      return content;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: content,
      ),
    );
  }
}
