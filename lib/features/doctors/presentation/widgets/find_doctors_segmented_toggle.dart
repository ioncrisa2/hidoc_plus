import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class FindDoctorsSegmentedToggle<T> extends StatelessWidget {
  const FindDoctorsSegmentedToggle({
    super.key,
    required this.leftLabel,
    required this.rightLabel,
    required this.leftValue,
    required this.rightValue,
    required this.selectedValue,
    required this.onChanged,
  });

  final String leftLabel;
  final String rightLabel;
  final T leftValue;
  final T rightValue;
  final T selectedValue;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxs),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Row(
        children: [
          Expanded(
            child: _ToggleOption<T>(
              label: leftLabel,
              value: leftValue,
              selectedValue: selectedValue,
              onTap: onChanged,
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: _ToggleOption<T>(
              label: rightLabel,
              value: rightValue,
              selectedValue: selectedValue,
              onTap: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleOption<T> extends StatelessWidget {
  const _ToggleOption({
    required this.label,
    required this.value,
    required this.selectedValue,
    required this.onTap,
  });

  final String label;
  final T value;
  final T selectedValue;
  final ValueChanged<T> onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == selectedValue;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap(value),
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: Ink(
          height: 36,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Center(
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
