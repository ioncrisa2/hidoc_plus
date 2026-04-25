import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';

enum AppButtonVariant { primary, secondary, tonal, outline }

enum AppButtonSize { regular, compact }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.regular,
    this.expand = true,
    this.iconTrailing = true,
    this.height,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.textStyle,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool expand;
  final bool iconTrailing;
  final double? height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final minimumHeight =
        height ??
        switch (size) {
          AppButtonSize.regular => 48.0,
          AppButtonSize.compact => 38.0,
        };
    final resolvedForeground = foregroundColor ?? _foregroundColor;
    final resolvedBackground = backgroundColor ?? _backgroundColor;
    final resolvedTextStyle = textStyle ?? _defaultTextStyle(context);
    final child = _ButtonContent(
      label: label,
      icon: icon,
      iconTrailing: iconTrailing,
    );

    final button = switch (variant) {
      AppButtonVariant.outline => OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: Size.fromHeight(minimumHeight),
          backgroundColor: resolvedBackground,
          foregroundColor: resolvedForeground,
          disabledForegroundColor: AppColors.outline,
          disabledBackgroundColor: AppColors.surface,
          side: BorderSide(
            color:
                borderColor ??
                AppColors.outlineVariant.withValues(
                  alpha: onPressed == null ? 0.72 : 1,
                ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          textStyle: resolvedTextStyle,
        ),
        child: child,
      ),
      _ => FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          minimumSize: Size.fromHeight(minimumHeight),
          backgroundColor: resolvedBackground,
          foregroundColor: resolvedForeground,
          disabledBackgroundColor: AppColors.outlineVariant.withValues(
            alpha: 0.6,
          ),
          disabledForegroundColor: AppColors.onPrimary.withValues(alpha: 0.82),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            side: borderColor == null
                ? BorderSide.none
                : BorderSide(color: borderColor!),
          ),
          elevation: 0,
          textStyle: resolvedTextStyle,
        ),
        child: child,
      ),
    };

    if (!expand) {
      return button;
    }

    return SizedBox(width: double.infinity, child: button);
  }

  Color get _backgroundColor {
    switch (variant) {
      case AppButtonVariant.primary:
        return AppColors.primaryContainer;
      case AppButtonVariant.secondary:
        return AppColors.surfaceContainer;
      case AppButtonVariant.tonal:
        return AppColors.surfaceContainerLow;
      case AppButtonVariant.outline:
        return AppColors.surface;
    }
  }

  Color get _foregroundColor {
    switch (variant) {
      case AppButtonVariant.primary:
        return AppColors.onPrimary;
      case AppButtonVariant.secondary:
      case AppButtonVariant.tonal:
        return AppColors.primary;
      case AppButtonVariant.outline:
        return AppColors.primaryContainer;
    }
  }

  TextStyle? _defaultTextStyle(BuildContext context) {
    final base = switch (size) {
      AppButtonSize.regular => Theme.of(context).textTheme.labelLarge,
      AppButtonSize.compact => Theme.of(context).textTheme.labelMedium,
    };

    if (base == null) {
      return null;
    }

    return TextStyle(
      inherit: true,
      fontSize: base.fontSize,
      height: base.height,
      fontWeight: FontWeight.w700,
      letterSpacing: base.letterSpacing,
      wordSpacing: base.wordSpacing,
      textBaseline: base.textBaseline,
      fontFamily: base.fontFamily,
      overflow: base.overflow,
      leadingDistribution: base.leadingDistribution,
      locale: base.locale,
    );
  }
}

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    required this.label,
    required this.icon,
    required this.iconTrailing,
  });

  final String label;
  final IconData? icon;
  final bool iconTrailing;

  @override
  Widget build(BuildContext context) {
    if (icon == null) {
      return Text(label);
    }

    final iconWidget = Icon(icon, size: 18);
    final labelWidget = Text(label);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: iconTrailing
          ? [labelWidget, const SizedBox(width: 8), iconWidget]
          : [iconWidget, const SizedBox(width: 8), labelWidget],
    );
  }
}
