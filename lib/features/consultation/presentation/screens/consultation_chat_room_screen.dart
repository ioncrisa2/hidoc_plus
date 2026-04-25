import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/app_icon_circle_button.dart';
import '../models/consultation_chat_room_args.dart';

class ConsultationChatRoomScreen extends StatelessWidget {
  const ConsultationChatRoomScreen({super.key, required this.args});

  final ConsultationChatRoomArgs args;

  @override
  Widget build(BuildContext context) {
    final messages = _buildMessages(args);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: AppColors.surfaceContainerHighest,
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.only(left: AppSpacing.md),
          child: Align(
            alignment: Alignment.centerLeft,
            child: AppIconCircleButton(
              icon: Icons.arrow_back_rounded,
              onTap: () => Navigator.of(context).maybePop(),
            ),
          ),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            AppAvatar(
              size: 38,
              imageUrl: args.imageUrl,
              initials: args.initials ?? 'DR',
              radius: AppRadius.md,
              backgroundColor: args.accentColor,
              foregroundColor: args.accentTextColor,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    args.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    args.statusLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 448),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(AppRadius.lg),
                      ),
                    ),
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.md,
                        AppSpacing.md,
                        AppSpacing.md,
                        AppSpacing.lg,
                      ),
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppSpacing.md,
                            ),
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.sm,
                                  vertical: AppSpacing.xs,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceContainerLow,
                                  borderRadius: BorderRadius.circular(
                                    AppRadius.pill,
                                  ),
                                ),
                                child: Text(
                                  'Today, 10:42 AM',
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        color: AppColors.onSurfaceVariant,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ),
                          );
                        }

                        final message = messages[index - 1];
                        return _MessageBubble(message: message);
                      },
                    ),
                  ),
                ),
                _ChatComposer(doctorName: args.name, onSendTap: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<_ChatMessage> _buildMessages(ConsultationChatRoomArgs args) {
    return [
      _ChatMessage(
        text:
            'Hello, I reviewed your latest update. How have you been feeling since yesterday?',
        timeLabel: '10:12 AM',
        isFromDoctor: true,
      ),
      const _ChatMessage(
        text:
            'Much better today. The dizziness is less frequent, but I still feel tired in the afternoon.',
        timeLabel: '10:18 AM',
        isFromDoctor: false,
      ),
      _ChatMessage(
        text:
            'That is a good sign. Please continue the medication after meals and keep your water intake consistent.',
        timeLabel: '10:26 AM',
        isFromDoctor: true,
      ),
      const _ChatMessage(
        text:
            'Understood. Should I continue with the same dose for the next three days?',
        timeLabel: '10:31 AM',
        isFromDoctor: false,
      ),
      _ChatMessage(
        text:
            'Yes. Continue the same dose for three days, then message me again if the symptoms return or worsen.',
        timeLabel: args.timeLabel,
        isFromDoctor: true,
      ),
    ];
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final _ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final bubbleColor = message.isFromDoctor
        ? AppColors.surfaceContainerLow
        : AppColors.primaryContainer;
    final textColor = message.isFromDoctor
        ? AppColors.onSurface
        : AppColors.onPrimary;
    final timeColor = message.isFromDoctor
        ? AppColors.onSurfaceVariant
        : AppColors.onPrimary.withValues(alpha: 0.82);

    return Align(
      alignment: message.isFromDoctor
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 292),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: message.isFromDoctor
                  ? Border.all(color: AppColors.surfaceContainerHigh)
                  : null,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.sm,
                AppSpacing.sm,
                AppSpacing.sm,
                AppSpacing.xs,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: textColor,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      message.timeLabel,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: timeColor,
                        fontWeight: FontWeight.w600,
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

class _ChatComposer extends StatelessWidget {
  const _ChatComposer({required this.doctorName, required this.onSendTap});

  final String doctorName;
  final VoidCallback onSendTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(
            color: AppColors.outlineVariant.withValues(alpha: 0.55),
            width: 0.7,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints(minHeight: 48),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                border: Border.all(color: AppColors.outlineVariant),
              ),
              child: Text(
                'Message $doctorName',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.outline),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          AppIconCircleButton(
            icon: Icons.send_rounded,
            onTap: onSendTap,
            backgroundColor: AppColors.primaryContainer,
            foregroundColor: AppColors.onPrimary,
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  const _ChatMessage({
    required this.text,
    required this.timeLabel,
    required this.isFromDoctor,
  });

  final String text;
  final String timeLabel;
  final bool isFromDoctor;
}
