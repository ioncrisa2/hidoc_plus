import 'package:flutter/material.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_icon_circle_button.dart';
import '../../../../core/widgets/app_logo.dart';

class DashboardTopBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.background,
      elevation: 0,
      scrolledUnderElevation: 1,
      shadowColor: AppColors.surfaceContainerHighest,
      titleSpacing: AppSpacing.md,
      title: const AppLogo(variant: AppLogoVariant.core, height: 30),
      actions: [
        AppIconCircleButton(
          icon: Icons.notifications_outlined,
          onTap: () => Navigator.pushNamed(context, AppRoutes.notificationHub),
          backgroundColor: AppColors.surfaceContainer,
        ),
        const SizedBox(width: AppSpacing.xs),
        AppIconCircleButton(
          icon: Icons.search_rounded,
          onTap: () => Navigator.pushNamed(context, AppRoutes.searchHub),
          backgroundColor: AppColors.surfaceContainer,
        ),
        const SizedBox(width: AppSpacing.md),
      ],
    );
  }
}
