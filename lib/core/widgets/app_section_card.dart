import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import 'app_surface_card.dart';

class AppSectionCard extends StatelessWidget {
  const AppSectionCard({
    super.key,
    required this.child,
    this.header,
    this.title,
    this.leading,
    this.action,
    this.actionLabel,
    this.onAction,
    this.titleStyle,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.radius = AppRadius.lg,
    this.backgroundColor = AppColors.surface,
    this.borderColor = AppColors.surfaceContainerHighest,
    this.headerBottomSpacing = AppSpacing.md,
  });

  final Widget child;
  final Widget? header;
  final String? title;
  final Widget? leading;
  final Widget? action;
  final String? actionLabel;
  final VoidCallback? onAction;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry padding;
  final double radius;
  final Color backgroundColor;
  final Color borderColor;
  final double headerBottomSpacing;

  @override
  Widget build(BuildContext context) {
    final resolvedHeader = header ?? _buildHeader(context);

    return AppSurfaceCard(
      padding: padding,
      radius: radius,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (resolvedHeader != null) ...[
            resolvedHeader,
            SizedBox(height: headerBottomSpacing),
          ],
          child,
        ],
      ),
    );
  }

  Widget? _buildHeader(BuildContext context) {
    if (title == null &&
        leading == null &&
        action == null &&
        actionLabel == null) {
      return null;
    }

    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        if (leading != null) ...[
          leading!,
          const SizedBox(width: AppSpacing.xs),
        ],
        if (title != null)
          Expanded(
            child: Text(
              title!,
              style:
                  titleStyle ??
                  textTheme.titleMedium?.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
            ),
          )
        else
          const Spacer(),
        if (action != null)
          action!
        else if (actionLabel != null)
          TextButton(
            onPressed: onAction,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              actionLabel!,
              style: textTheme.titleSmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }
}
