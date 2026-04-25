import 'package:flutter/material.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../widgets/auth_headline.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_shell.dart';
import '../widgets/welcome_hero_art.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AuthShell(
      child: Column(
        children: [
          const AuthLogo(height: 76),
          const SizedBox(height: AppSpacing.xxl),
          const WelcomeHeroArt(),
          const SizedBox(height: AppSpacing.xl),
          const AuthHeadline(
            title: 'Your Health,\nSimplified',
            subtitle: 'Consultations, records, and check-ups\nin one place.',
            centered: true,
          ),
          const SizedBox(height: AppSpacing.xl),
          AppButton(
            label: 'Log In',
            icon: Icons.arrow_forward_rounded,
            onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: 'Register',
            variant: AppButtonVariant.secondary,
            onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.lock_outline_rounded,
                  size: 14,
                  color: AppColors.outline,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Flexible(
                child: Text(
                  'Secure access to your consultations,\nrecords, and appointments.',
                  textAlign: TextAlign.center,
                  style: textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.outline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
