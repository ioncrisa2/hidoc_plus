import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_section_card.dart';

class DoctorProfileSectionCard extends StatelessWidget {
  const DoctorProfileSectionCard({
    super.key,
    required this.title,
    required this.child,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final Widget child;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      title: title,
      actionLabel: actionLabel,
      onAction: onAction,
      titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: AppColors.onSurfaceVariant,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
      ),
      child: child,
    );
  }
}
