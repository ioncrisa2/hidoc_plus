import 'package:flutter/material.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_icon_circle_button.dart';

class DashboardSectionTopBar extends StatelessWidget
    implements PreferredSizeWidget {
  const DashboardSectionTopBar({
    super.key,
    required this.title,
    this.leading,
    this.leadingIcon,
    this.trailingIcon,
    this.onLeadingTap,
    this.onTrailingTap,
  });

  final String title;
  final Widget? leading;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final VoidCallback? onLeadingTap;
  final VoidCallback? onTrailingTap;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.background,
      elevation: 0,
      shadowColor: AppColors.surfaceContainerHighest,
      scrolledUnderElevation: 1,
      centerTitle: true,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontSize: 22,
          color: AppColors.onSurface,
        ),
      ),
      leadingWidth: 64,
      leading: leading != null
          ? Padding(
              padding: const EdgeInsets.only(left: AppSpacing.md),
              child: Align(alignment: Alignment.centerLeft, child: leading),
            )
          : leadingIcon == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(left: AppSpacing.md),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AppIconCircleButton(
                  icon: leadingIcon!,
                  onTap: onLeadingTap ?? () {},
                  size: 36,
                  iconSize: 18,
                  backgroundColor: AppColors.surfaceContainer,
                  foregroundColor: AppColors.primary,
                ),
              ),
            ),
      actions: [
        if (trailingIcon != null)
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: AppIconCircleButton(
              icon: trailingIcon!,
              onTap:
                  onTrailingTap ??
                  () {
                    if (trailingIcon == Icons.notifications_none_rounded) {
                      Navigator.pushNamed(context, AppRoutes.notificationHub);
                      return;
                    }
                  },
              size: 36,
              iconSize: 18,
              backgroundColor: AppColors.surfaceContainer,
              foregroundColor: AppColors.primary,
            ),
          ),
      ],
    );
  }
}
