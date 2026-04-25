import 'package:flutter/material.dart';

import '../../../../core/widgets/app_search_field.dart';

class ConsultationSearchBar extends StatelessWidget {
  const ConsultationSearchBar({super.key, required this.hintText, this.onTap});

  final String hintText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppSearchField(
      hintText: hintText,
      onTap: onTap,
      readOnly: true,
      height: 50,
    );
  }
}
