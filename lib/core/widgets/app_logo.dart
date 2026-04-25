import 'package:flutter/material.dart';

import '../assets/app_assets.dart';

enum AppLogoVariant { full, core }

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.variant = AppLogoVariant.full,
    this.height = 54,
    this.alignment = Alignment.centerLeft,
  });

  final AppLogoVariant variant;
  final double height;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      variant == AppLogoVariant.full
          ? AppAssets.hidocLogoFull
          : AppAssets.hidocLogoCore,
      height: height,
      fit: BoxFit.contain,
      alignment: alignment,
      filterQuality: FilterQuality.high,
      semanticLabel: variant == AppLogoVariant.full
          ? 'HiDoc+ logo'
          : 'HiDoc+ core logo',
      errorBuilder: (context, error, stackTrace) {
        return const SizedBox.shrink();
      },
    );
  }
}
