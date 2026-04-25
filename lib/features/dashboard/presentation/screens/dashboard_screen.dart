import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_logo.dart';
import '../widgets/dashboard_bottom_nav.dart';
import '../widgets/dashboard_home_tab.dart';
import '../widgets/dashboard_profile_tab.dart';
import '../widgets/dashboard_section_top_bar.dart';
import '../widgets/dashboard_services_tab.dart';
import '../widgets/dashboard_top_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _navIndex = 0;

  PreferredSizeWidget _buildAppBar() {
    switch (_navIndex) {
      case 1:
        return const DashboardSectionTopBar(
          title: 'Services',
          leading: AppLogo(variant: AppLogoVariant.core, height: 28),
          trailingIcon: Icons.notifications_none_rounded,
        );
      case 2:
        return const DashboardSectionTopBar(
          title: 'Profile',
          trailingIcon: Icons.settings_rounded,
        );
      case 0:
      default:
        return const DashboardTopBar();
    }
  }

  Widget _buildBody() {
    switch (_navIndex) {
      case 1:
        return const DashboardServicesTab();
      case 2:
        return const DashboardProfileTab();
      case 0:
      default:
        return const DashboardHomeTab();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      bottomNavigationBar: DashboardBottomNav(
        currentIndex: _navIndex,
        onTap: (index) => setState(() => _navIndex = index),
      ),
      body: _buildBody(),
    );
  }
}
