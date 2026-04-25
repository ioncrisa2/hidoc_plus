import 'package:flutter/material.dart';

import '../../../../core/widgets/app_metric_tile.dart';

class DashboardProfileMetricCard extends StatelessWidget {
  const DashboardProfileMetricCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return AppMetricTile(
      icon: icon,
      label: label,
      value: value,
      iconColor: iconColor,
      padding: const EdgeInsets.all(12),
    );
  }
}
