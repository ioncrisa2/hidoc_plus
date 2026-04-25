import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/widgets/app_search_field.dart';

class FindDoctorsSearchField extends StatelessWidget {
  const FindDoctorsSearchField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return AppSearchField(
      controller: controller,
      hintText: hintText,
      onChanged: onChanged,
      height: 44,
      radius: AppRadius.md,
    );
  }
}
