import 'package:flutter/material.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/app_list_row.dart';
import '../models/consultation_chat_room_args.dart';
import '../../../dashboard/presentation/widgets/dashboard_bottom_nav.dart';
import '../../../dashboard/presentation/widgets/dashboard_section_top_bar.dart';

class ConsultationMessagesScreen extends StatelessWidget {
  const ConsultationMessagesScreen({super.key});

  static const _conversations = <_ConversationItem>[
    _ConversationItem(
      name: 'Dr. Aris Taylor',
      preview:
          'Your latest lab results look very good. We can continue the same plan.',
      timeLabel: '10:42 AM',
      imageUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
      unread: true,
    ),
    _ConversationItem(
      name: 'Dr. Sarah Jenkins',
      preview:
          'I\'ve forwarded the prescription to your pharmacy for pickup later today.',
      timeLabel: 'Yesterday',
      imageUrl: 'https://randomuser.me/api/portraits/women/33.jpg',
    ),
    _ConversationItem(
      name: 'Dr. Elena Rodriguez',
      preview:
          'How are you feeling after the new medication? Let me know if symptoms change.',
      timeLabel: 'Tue',
      initials: 'ER',
      accentColor: AppColors.primaryFixed,
      accentTextColor: AppColors.primary,
    ),
    _ConversationItem(
      name: 'Dr. James Wilson',
      preview:
          'Great session today. Don\'t forget the breathing exercise twice a day.',
      timeLabel: 'Mon',
      imageUrl: 'https://randomuser.me/api/portraits/men/41.jpg',
    ),
    _ConversationItem(
      name: 'Dr. Marcus Chen',
      preview:
          'Please confirm your insurance details before the next appointment.',
      timeLabel: 'Oct 12',
      initials: 'MC',
      accentColor: AppColors.surfaceContainer,
      accentTextColor: AppColors.primaryContainer,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final topInset = (screenHeight * 0.012).clamp(AppSpacing.sm, AppSpacing.md);
    final bottomInset = (screenHeight * 0.028).clamp(
      AppSpacing.lg,
      AppSpacing.xxxl,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: DashboardSectionTopBar(
        title: 'Messages',
        leadingIcon: Icons.arrow_back_rounded,
        trailingIcon: Icons.notifications_none_rounded,
        onLeadingTap: () => Navigator.of(context).maybePop(),
      ),
      bottomNavigationBar: DashboardBottomNav(
        currentIndex: 1,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.consultationHub,
              (route) => route.settings.name == AppRoutes.dashboard,
            );
            return;
          }

          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.dashboard,
            (route) => false,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primaryContainer,
        foregroundColor: AppColors.onPrimary,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: const Icon(Icons.add_rounded),
      ),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 448),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.md,
                topInset,
                AppSpacing.md,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      border: Border.all(color: AppColors.outlineVariant),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search_rounded,
                          color: AppColors.outline,
                          size: 20,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          'Search messages or doctors',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppColors.outline),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'RECENT CONVERSATIONS',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(AppRadius.lg),
                        ),
                      ),
                      child: ListView.separated(
                        padding: EdgeInsets.fromLTRB(
                          0,
                          AppSpacing.xs,
                          0,
                          bottomInset,
                        ),
                        itemCount: _conversations.length,
                        separatorBuilder: (context, index) => const Divider(
                          height: 0,
                          indent: AppSpacing.md,
                          endIndent: AppSpacing.md,
                          color: AppColors.surfaceContainerLow,
                        ),
                        itemBuilder: (context, index) {
                          final item = _conversations[index];
                          return _ConversationTile(
                            item: item,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.consultationChatRoom,
                                arguments: item.toChatRoomArgs(),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  const _ConversationTile({required this.item, required this.onTap});

  final _ConversationItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppListRow(
      onTap: onTap,
      crossAxisAlignment: CrossAxisAlignment.start,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      leading: AppAvatar(
        size: 46,
        imageUrl: item.imageUrl,
        initials: item.initials,
        radius: AppRadius.md,
        backgroundColor: item.accentColor,
        foregroundColor: item.accentTextColor,
        fallbackIcon: Icons.person_rounded,
      ),
      title: Text(
        item.name,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: AppColors.onSurface,
          fontWeight: FontWeight.w700,
        ),
      ),
      titleTrailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            item.timeLabel,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.outline,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (item.unread) ...[
            const SizedBox(width: 6),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.primaryContainer,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
      subtitleSpacing: 4,
      subtitle: Text(
        item.preview,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.onSurfaceVariant,
          height: 1.35,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _ConversationItem {
  const _ConversationItem({
    required this.name,
    required this.preview,
    required this.timeLabel,
    this.imageUrl,
    this.initials,
    this.unread = false,
    this.accentColor = AppColors.primaryFixed,
    this.accentTextColor = AppColors.primary,
  });

  final String name;
  final String preview;
  final String timeLabel;
  final String? imageUrl;
  final String? initials;
  final bool unread;
  final Color accentColor;
  final Color accentTextColor;

  ConsultationChatRoomArgs toChatRoomArgs() {
    return ConsultationChatRoomArgs(
      name: name,
      timeLabel: timeLabel,
      imageUrl: imageUrl,
      initials: initials,
      accentColor: accentColor,
      accentTextColor: accentTextColor,
    );
  }
}
