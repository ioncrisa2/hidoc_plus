import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';

class AuthHeadline extends StatelessWidget {
  const AuthHeadline({
    super.key,
    required this.title,
    required this.subtitle,
    this.centered = false,
  });

  final String title;
  final String subtitle;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: centered
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: centered ? TextAlign.center : TextAlign.start,
          style: textTheme.headlineSmall,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          subtitle,
          textAlign: centered ? TextAlign.center : TextAlign.start,
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }
}
