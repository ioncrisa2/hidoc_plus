import 'package:flutter/material.dart';

import '../../../../core/widgets/app_logo.dart';

class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key, this.height = 54});

  final double height;

  @override
  Widget build(BuildContext context) {
    return AppLogo(
      variant: AppLogoVariant.full,
      height: height,
      alignment: Alignment.centerLeft,
    );
  }
}
