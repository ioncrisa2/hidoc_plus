import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';

class AppSearchField extends StatelessWidget {
  const AppSearchField({
    super.key,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.onTap,
    this.trailing,
    this.readOnly = false,
    this.autofocus = false,
    this.height = 48,
    this.radius = AppRadius.pill,
    this.leadingIcon = Icons.search_rounded,
    this.leadingIconSize = 20,
    this.textInputAction = TextInputAction.search,
    this.hintStyle,
    this.textStyle,
    this.contentPadding,
  });

  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool readOnly;
  final bool autofocus;
  final double height;
  final double radius;
  final IconData leadingIcon;
  final double leadingIconSize;
  final TextInputAction textInputAction;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final resolvedTextStyle =
        textStyle ?? textTheme.bodyMedium?.copyWith(color: AppColors.onSurface);
    final resolvedHintStyle =
        hintStyle ?? textTheme.bodyMedium?.copyWith(color: AppColors.outline);
    final decoration = BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: AppColors.outlineVariant),
    );

    if (readOnly) {
      final hasValue = controller?.text.trim().isNotEmpty ?? false;

      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(radius),
          child: Ink(
            height: height,
            padding:
                contentPadding ??
                const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            decoration: decoration,
            child: Row(
              children: [
                Icon(
                  leadingIcon,
                  size: leadingIconSize,
                  color: AppColors.outline,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    hasValue ? controller!.text : hintText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: hasValue ? resolvedTextStyle : resolvedHintStyle,
                  ),
                ),
                if (trailing != null) ...[
                  const SizedBox(width: AppSpacing.sm),
                  trailing!,
                ],
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      height: height,
      padding:
          contentPadding ??
          const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: decoration,
      child: Row(
        children: [
          Icon(leadingIcon, size: leadingIconSize, color: AppColors.outline),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onTap: onTap,
              readOnly: readOnly,
              autofocus: autofocus,
              textInputAction: textInputAction,
              style: resolvedTextStyle,
              decoration: InputDecoration(
                isDense: true,
                isCollapsed: true,
                filled: false,
                contentPadding: EdgeInsets.zero,
                hintText: hintText,
                hintStyle: resolvedHintStyle,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: AppSpacing.sm),
            trailing!,
          ],
        ],
      ),
    );
  }
}
