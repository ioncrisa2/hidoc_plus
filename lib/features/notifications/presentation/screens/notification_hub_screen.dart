import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../widgets/notification_hub_card.dart';

class NotificationHubScreen extends StatefulWidget {
  const NotificationHubScreen({super.key});

  @override
  State<NotificationHubScreen> createState() => _NotificationHubScreenState();
}

class _NotificationHubScreenState extends State<NotificationHubScreen> {
  final List<_NotificationItem> _items = [
    _NotificationItem(
      id: 'consult-confirmed',
      section: 'TODAY',
      type: _NotificationType.appointment,
      title: 'Consultation Confirmed',
      message:
          'Your appointment with Dr. Julian Sterling is scheduled for tomorrow at 10:30 AM.',
      timestamp: '30m ago',
      icon: Icons.calendar_month_outlined,
      iconBackgroundColor: AppColors.primaryFixed,
      iconColor: AppColors.primary,
      isUnread: true,
    ),
    _NotificationItem(
      id: 'prescription-refill',
      section: 'TODAY',
      type: _NotificationType.prescription,
      title: 'Prescription Refill Reminder',
      message: 'Amoxicillin refill will be available in 2 days.',
      timestamp: '2h ago',
      icon: Icons.medication_outlined,
      iconBackgroundColor: AppColors.primaryFixed,
      iconColor: AppColors.primary,
      isUnread: true,
    ),
    _NotificationItem(
      id: 'payment-required',
      section: 'TODAY',
      type: _NotificationType.update,
      title: 'Payment Required',
      message: 'Your consultation booking is waiting for payment confirmation.',
      timestamp: '3h ago',
      icon: Icons.account_balance_wallet_outlined,
      iconBackgroundColor: AppColors.errorContainer,
      iconColor: AppColors.error,
      actionLabel: 'Pay Now',
      isUnread: true,
    ),
    _NotificationItem(
      id: 'mcu-reminder',
      section: 'YESTERDAY',
      type: _NotificationType.appointment,
      title: 'MCU Reminder',
      message:
          'Your facility visit check-up is coming up on Friday at 09:00 AM.',
      timestamp: 'Yesterday',
      icon: Icons.health_and_safety_outlined,
      iconBackgroundColor: AppColors.primaryFixed,
      iconColor: AppColors.primary,
      actionLabel: 'View Details',
    ),
    _NotificationItem(
      id: 'lab-result',
      section: 'YESTERDAY',
      type: _NotificationType.update,
      title: 'Lab Result Available',
      message: 'Your latest lab result is now ready to view.',
      timestamp: 'Yesterday',
      icon: Icons.science_outlined,
      iconBackgroundColor: AppColors.primaryFixed,
      iconColor: AppColors.primary,
      actionLabel: 'View',
    ),
    _NotificationItem(
      id: 'pharmacy-order',
      section: 'YESTERDAY',
      type: _NotificationType.prescription,
      title: 'Pharmacy Order Update',
      message: 'Your medicine order is out for delivery.',
      timestamp: 'Yesterday',
      icon: Icons.local_shipping_outlined,
      iconBackgroundColor: AppColors.primaryFixed,
      iconColor: AppColors.primary,
      actionLabel: 'Track Order',
    ),
    _NotificationItem(
      id: 'health-article',
      section: 'EARLIER',
      type: _NotificationType.update,
      title: 'New Health Article',
      message: '5 Tips for Better Sleep has been added to your health feed.',
      timestamp: 'Oct 12',
      icon: Icons.article_outlined,
      iconBackgroundColor: AppColors.primaryFixed,
      iconColor: AppColors.primary,
    ),
    _NotificationItem(
      id: 'consult-summary',
      section: 'EARLIER',
      type: _NotificationType.appointment,
      title: 'Consultation Summary Ready',
      message: 'Your recent consultation summary is now available.',
      timestamp: 'Oct 10',
      icon: Icons.summarize_outlined,
      iconBackgroundColor: AppColors.primaryFixed,
      iconColor: AppColors.primary,
    ),
    _NotificationItem(
      id: 'security-alert',
      section: 'EARLIER',
      type: _NotificationType.update,
      title: 'Security Alert',
      message: 'A new device was used to sign in to your account.',
      timestamp: 'Oct 08',
      icon: Icons.gpp_maybe_outlined,
      iconBackgroundColor: AppColors.errorContainer,
      iconColor: AppColors.error,
    ),
  ];

  int _selectedFilterIndex = 0;

  int get _unreadCount => _items.where((item) => item.isUnread).length;

  List<_NotificationItem> get _filteredItems {
    switch (_selectedFilterIndex) {
      case 1:
        return _items.where((item) => item.isUnread).toList();
      case 2:
        return _items
            .where((item) => item.type == _NotificationType.appointment)
            .toList();
      case 3:
        return _items
            .where((item) => item.type == _NotificationType.prescription)
            .toList();
      case 4:
        return _items
            .where((item) => item.type == _NotificationType.update)
            .toList();
      case 0:
      default:
        return _items;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final groupedItems = <String, List<_NotificationItem>>{};

    for (final item in _filteredItems) {
      groupedItems.putIfAbsent(item.section, () => []).add(item);
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: AppColors.surfaceContainerHighest,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.primary),
        ),
        centerTitle: true,
        title: Text(
          'Notifications',
          style: textTheme.titleLarge?.copyWith(color: AppColors.primary),
        ),
        actions: [
          TextButton(
            onPressed: _markAllAsRead,
            style: TextButton.styleFrom(foregroundColor: AppColors.primary),
            child: const Text('Mark all as read'),
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilterChips(textTheme),
            const SizedBox(height: AppSpacing.lg),
            ...groupedItems.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.key,
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.outline,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    ...entry.value.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: NotificationHubCard(
                          icon: item.icon,
                          iconBackgroundColor: item.iconBackgroundColor,
                          iconColor: item.iconColor,
                          title: item.title,
                          message: item.message,
                          timestamp: item.timestamp,
                          actionLabel: item.actionLabel,
                          onAction: () {},
                          isUnread: item.isUnread,
                        ),
                      );
                    }),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips(TextTheme textTheme) {
    final filters = [
      _FilterChipData(label: 'All'),
      _FilterChipData(label: 'Unread', badge: '$_unreadCount new'),
      const _FilterChipData(label: 'Appointments'),
      const _FilterChipData(label: 'Prescriptions'),
      const _FilterChipData(label: 'Updates'),
    ];

    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (context, index) =>
            const SizedBox(width: AppSpacing.xs),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = _selectedFilterIndex == index;

          return ChoiceChip(
            selected: isSelected,
            onSelected: (_) {
              setState(() => _selectedFilterIndex = index);
            },
            showCheckmark: false,
            selectedColor: AppColors.primary,
            backgroundColor: AppColors.surfaceContainerLow,
            side: BorderSide(
              color: isSelected ? AppColors.primary : AppColors.outlineVariant,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  filter.label,
                  style: textTheme.labelMedium?.copyWith(
                    color: isSelected ? AppColors.onPrimary : AppColors.outline,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (filter.badge != null) ...[
                  const SizedBox(width: AppSpacing.xs),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs - 2,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryDark
                          : AppColors.primaryFixed,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Text(
                      filter.badge!,
                      style: textTheme.labelSmall?.copyWith(
                        color: isSelected
                            ? AppColors.onPrimary
                            : AppColors.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  void _markAllAsRead() {
    setState(() {
      for (var index = 0; index < _items.length; index++) {
        _items[index] = _items[index].copyWith(isUnread: false);
      }
    });
  }
}

class _FilterChipData {
  const _FilterChipData({required this.label, this.badge});

  final String label;
  final String? badge;
}

enum _NotificationType { appointment, prescription, update }

class _NotificationItem {
  const _NotificationItem({
    required this.id,
    required this.section,
    required this.type,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconColor,
    this.actionLabel,
    this.isUnread = false,
  });

  final String id;
  final String section;
  final _NotificationType type;
  final String title;
  final String message;
  final String timestamp;
  final IconData icon;
  final Color iconBackgroundColor;
  final Color iconColor;
  final String? actionLabel;
  final bool isUnread;

  _NotificationItem copyWith({bool? isUnread}) {
    return _NotificationItem(
      id: id,
      section: section,
      type: type,
      title: title,
      message: message,
      timestamp: timestamp,
      icon: icon,
      iconBackgroundColor: iconBackgroundColor,
      iconColor: iconColor,
      actionLabel: actionLabel,
      isUnread: isUnread ?? this.isUnread,
    );
  }
}
