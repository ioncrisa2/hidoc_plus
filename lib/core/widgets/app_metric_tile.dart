import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';

enum AppMetricTileLayout { stacked, leading }

class AppMetricTile extends StatelessWidget {
  const AppMetricTile({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.layout = AppMetricTileLayout.stacked,
    this.backgroundColor = AppColors.surface,
    this.borderColor = AppColors.surfaceContainerHighest,
    this.radius = AppRadius.md,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.iconColor = AppColors.primary,
    this.iconSize = 16,
    this.iconGap = AppSpacing.xs,
    this.labelValueSpacing = AppSpacing.xs,
    this.labelStyle,
    this.valueStyle,
    this.iconBackgroundColor,
    this.iconContainerSize,
    this.iconContainerRadius,
    this.iconContainerShape = BoxShape.rectangle,
    this.fillVerticalSpace = false,
    this.valueMaxLines,
    this.valueOverflow,
  });

  final String label;
  final String value;
  final IconData? icon;
  final AppMetricTileLayout layout;
  final Color backgroundColor;
  final Color borderColor;
  final double radius;
  final EdgeInsetsGeometry padding;
  final Color iconColor;
  final double iconSize;
  final double iconGap;
  final double labelValueSpacing;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final Color? iconBackgroundColor;
  final double? iconContainerSize;
  final double? iconContainerRadius;
  final BoxShape iconContainerShape;
  final bool fillVerticalSpace;
  final int? valueMaxLines;
  final TextOverflow? valueOverflow;

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor, width: 0.5),
    );

    return DecoratedBox(
      decoration: decoration,
      child: Padding(
        padding: padding,
        child: switch (layout) {
          AppMetricTileLayout.stacked => _buildStacked(context),
          AppMetricTileLayout.leading => _buildLeading(context),
        },
      ),
    );
  }

  Widget _buildStacked(BuildContext context) {
    final resolvedValue = Text(
      value,
      maxLines: valueMaxLines,
      overflow: valueOverflow,
      style:
          valueStyle ??
          Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w800,
          ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: fillVerticalSpace
          ? MainAxisAlignment.start
          : MainAxisAlignment.center,
      children: [
        Row(
          children: [
            if (icon != null) ...[_buildIcon(), SizedBox(width: iconGap)],
            Expanded(
              child: Text(
                label,
                style:
                    labelStyle ??
                    Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.outline,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
        SizedBox(height: labelValueSpacing),
        if (fillVerticalSpace)
          Expanded(
            child: Align(alignment: Alignment.bottomLeft, child: resolvedValue),
          )
        else
          resolvedValue,
      ],
    );
  }

  Widget _buildLeading(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null) ...[_buildIcon(), SizedBox(width: iconGap)],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style:
                    labelStyle ??
                    Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(height: labelValueSpacing),
              Text(
                value,
                maxLines: valueMaxLines,
                overflow: valueOverflow,
                style:
                    valueStyle ??
                    Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIcon() {
    if (icon == null) {
      return const SizedBox.shrink();
    }

    if (iconBackgroundColor == null && iconContainerSize == null) {
      return Icon(icon, size: iconSize, color: iconColor);
    }

    final size = iconContainerSize ?? 28;
    final shape = BoxDecoration(
      color: iconBackgroundColor ?? AppColors.surfaceContainerLow,
      shape: iconContainerShape,
      borderRadius: iconContainerShape == BoxShape.circle
          ? null
          : BorderRadius.circular(iconContainerRadius ?? AppRadius.sm),
    );

    return Container(
      width: size,
      height: size,
      decoration: shape,
      alignment: Alignment.center,
      child: Icon(icon, size: iconSize, color: iconColor),
    );
  }
}
