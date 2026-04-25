import 'package:flutter/material.dart';

import '../core/navigation/app_router.dart';
import '../core/navigation/app_routes.dart';
import '../core/theme/app_theme.dart';

class HiDocApp extends StatelessWidget {
  const HiDocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      initialRoute: AppRoutes.welcome,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
