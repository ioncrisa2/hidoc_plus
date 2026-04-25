import 'package:flutter/material.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_list_row.dart';
import '../../../../core/widgets/app_pill.dart';
import '../../../../core/widgets/app_section_header.dart';
import '../../../../core/widgets/app_surface_card.dart';
import '../../../dashboard/presentation/widgets/dashboard_section_top_bar.dart';
import '../../../doctors/presentation/models/doctor_mock_catalog.dart';
import '../../../doctors/presentation/models/doctor_profile_data.dart';
import '../models/book_consultation_args.dart';
import '../models/consultation_chat_room_args.dart';
import '../models/consultation_video_call_args.dart';
import '../models/reschedule_consultation_args.dart';
import '../widgets/consultation_active_session_card.dart';
import '../widgets/consultation_doctor_card.dart';
import '../widgets/consultation_search_bar.dart';
import '../widgets/consultation_specialty_card.dart';

class ConsultationHubScreen extends StatelessWidget {
  const ConsultationHubScreen({super.key});

  static const _activeSession = _ConsultationActiveSession(
    imageUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
    doctorName: 'Dr. Elena Rodriguez',
    specialty: 'Cardiologist',
  );

  static const _specialties = <_ConsultationSpecialty>[
    _ConsultationSpecialty(
      icon: Icons.psychology_alt_outlined,
      title: 'Mental Health',
      iconBg: AppColors.primaryFixed,
      iconColor: AppColors.primary,
    ),
    _ConsultationSpecialty(
      icon: Icons.spa_outlined,
      title: 'Dermatology',
      iconBg: AppColors.secondaryContainer,
      iconColor: AppColors.secondary,
    ),
    _ConsultationSpecialty(
      icon: Icons.hearing_outlined,
      title: 'Neurology',
      iconBg: AppColors.secondaryContainer,
      iconColor: AppColors.secondary,
    ),
  ];

  static final _upcomingAppointment = _UpcomingAppointmentData(
    doctor: DoctorMockCatalog.doctors[1],
    dateLabel: 'Tomorrow',
    timeLabel: '9:00 AM',
    modeLabel: 'Video Consultation',
  );

  static const _pendingActions = <_PendingActionItem>[
    _PendingActionItem(
      icon: Icons.event_note_rounded,
      title: 'Confirm appointment details',
      subtitle: 'Review schedule and session notes before tomorrow.',
      statusLabel: 'Today',
    ),
    _PendingActionItem(
      icon: Icons.description_outlined,
      title: 'Upload lab result',
      subtitle: 'Share your recent report before the follow-up consultation.',
      statusLabel: 'Needed',
    ),
    _PendingActionItem(
      icon: Icons.mark_chat_unread_rounded,
      title: 'Reply to Dr. Elena Rodriguez',
      subtitle: 'You have a follow-up message waiting in chat.',
      statusLabel: 'Unread',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final doctorsOnDuty = <DoctorProfileData>[
      DoctorMockCatalog.doctors[0],
      DoctorMockCatalog.doctors[1],
    ];
    final consultAgainDoctors = <DoctorProfileData>[
      DoctorMockCatalog.doctors[0],
      DoctorMockCatalog.doctors[3],
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: DashboardSectionTopBar(
        title: 'Consultations',
        leadingIcon: Icons.arrow_back_rounded,
        trailingIcon: Icons.chat_bubble_outline_rounded,
        onLeadingTap: () => Navigator.of(context).maybePop(),
        onTrailingTap: () =>
            Navigator.pushNamed(context, AppRoutes.consultationMessages),
      ),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 448),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConsultationSearchBar(
                    hintText: 'Search for doctors or symptoms',
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.findDoctors),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const AppSectionHeader(title: 'Active Sessions'),
                  const SizedBox(height: AppSpacing.xs),
                  ConsultationActiveSessionCard(
                    imageUrl: _activeSession.imageUrl,
                    doctorName: _activeSession.doctorName,
                    specialty: _activeSession.specialty,
                    onStartVideoCall: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.consultationVideoCall,
                        arguments: ConsultationVideoCallArgs(
                          doctor: DoctorMockCatalog.doctors.first,
                          appointmentLabel: 'Today, 10:30 AM',
                          sessionTimerLabel: '08:24',
                          topicLabel: 'Heart rhythm review',
                          note:
                              'We are reviewing your symptom trend, medication response, and the next cardiology care plan.',
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const AppSectionHeader(title: 'Upcoming Appointments'),
                  const SizedBox(height: AppSpacing.xs),
                  _UpcomingAppointmentCard(
                    appointment: _upcomingAppointment,
                    onOpenChat: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.consultationChatRoom,
                        arguments: _buildChatRoomArgs(
                          _upcomingAppointment.doctor,
                          statusLabel: 'Last reply 10:42 AM',
                        ),
                      );
                    },
                    onReschedule: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.rescheduleConsultation,
                        arguments: RescheduleConsultationArgs(
                          doctor: _upcomingAppointment.doctor,
                          currentDateLabel: _upcomingAppointment.dateLabel,
                          currentTimeLabel: _upcomingAppointment.timeLabel,
                          modeLabel: _upcomingAppointment.modeLabel,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppSectionHeader(
                    title: 'Doctors on Duty',
                    actionLabel: 'See all',
                    onAction: () =>
                        Navigator.pushNamed(context, AppRoutes.findDoctors),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: List.generate(doctorsOnDuty.length, (index) {
                      final doctor = doctorsOnDuty[index];
                      final hasTrailingGap = index < doctorsOnDuty.length - 1;

                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: hasTrailingGap ? AppSpacing.sm : 0,
                          ),
                          child: ConsultationDoctorCard(
                            imageUrl: doctor.imageUrl,
                            name: doctor.name,
                            specialty: doctor.specialty,
                            onBook: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.bookConsultation,
                                arguments: BookConsultationArgs(doctor: doctor),
                              );
                            },
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const AppSectionHeader(title: 'Consult Again'),
                  const SizedBox(height: AppSpacing.xs),
                  SizedBox(
                    height: 212,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: consultAgainDoctors.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: AppSpacing.sm),
                      itemBuilder: (context, index) {
                        final doctor = consultAgainDoctors[index];

                        return SizedBox(
                          width: 176,
                          child: _ConsultAgainCard(
                            doctor: doctor,
                            onBookAgain: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.bookConsultation,
                                arguments: BookConsultationArgs(
                                  doctor: doctor,
                                  slotLabel: doctor.nextAvailableLabel,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const AppSectionHeader(title: 'Pending Actions'),
                  const SizedBox(height: AppSpacing.xs),
                  AppSurfaceCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: List.generate(_pendingActions.length, (index) {
                        final item = _pendingActions[index];
                        final isLast = index == _pendingActions.length - 1;

                        return Column(
                          children: [
                            _PendingActionTile(
                              item: item,
                              onTap: () {
                                if (index == 2) {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.consultationChatRoom,
                                    arguments: _buildChatRoomArgs(
                                      DoctorMockCatalog.doctors.first,
                                      statusLabel: 'Online now',
                                    ),
                                  );
                                  return;
                                }

                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.bookConsultation,
                                  arguments: BookConsultationArgs(
                                    doctor: index == 0
                                        ? _upcomingAppointment.doctor
                                        : DoctorMockCatalog.doctors.first,
                                  ),
                                );
                              },
                            ),
                            if (!isLast)
                              const Divider(
                                height: 0,
                                indent: AppSpacing.md,
                                endIndent: AppSpacing.md,
                                color: AppColors.surfaceContainerLow,
                              ),
                          ],
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const AppSectionHeader(
                    title: 'Top Specialists',
                    actionLabel: 'Explore',
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _specialties.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: AppSpacing.sm),
                      itemBuilder: (context, index) {
                        final item = _specialties[index];

                        return SizedBox(
                          width: 112,
                          child: ConsultationSpecialtyCard(
                            icon: item.icon,
                            title: item.title,
                            iconBackgroundColor: item.iconBg,
                            iconColor: item.iconColor,
                            onTap: () {},
                          ),
                        );
                      },
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

  ConsultationChatRoomArgs _buildChatRoomArgs(
    DoctorProfileData doctor, {
    required String statusLabel,
  }) {
    return ConsultationChatRoomArgs(
      name: doctor.name,
      timeLabel: '10:42 AM',
      imageUrl: doctor.imageUrl,
      accentColor: AppColors.primaryFixed,
      accentTextColor: AppColors.primary,
      statusLabel: statusLabel,
    );
  }
}

class _ConsultationActiveSession {
  const _ConsultationActiveSession({
    required this.imageUrl,
    required this.doctorName,
    required this.specialty,
  });

  final String imageUrl;
  final String doctorName;
  final String specialty;
}

class _ConsultationSpecialty {
  const _ConsultationSpecialty({
    required this.icon,
    required this.title,
    required this.iconBg,
    required this.iconColor,
  });

  final IconData icon;
  final String title;
  final Color iconBg;
  final Color iconColor;
}

class _UpcomingAppointmentData {
  const _UpcomingAppointmentData({
    required this.doctor,
    required this.dateLabel,
    required this.timeLabel,
    required this.modeLabel,
  });

  final DoctorProfileData doctor;
  final String dateLabel;
  final String timeLabel;
  final String modeLabel;
}

class _PendingActionItem {
  const _PendingActionItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.statusLabel,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String statusLabel;
}

class _UpcomingAppointmentCard extends StatelessWidget {
  const _UpcomingAppointmentCard({
    required this.appointment,
    required this.onOpenChat,
    required this.onReschedule,
  });

  final _UpcomingAppointmentData appointment;
  final VoidCallback onOpenChat;
  final VoidCallback onReschedule;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppAvatar(
                size: 54,
                imageUrl: appointment.doctor.imageUrl,
                radius: AppRadius.md,
                fallbackIcon: Icons.person_rounded,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.doctor.name,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      appointment.doctor.specialty,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              AppPill(
                label: appointment.dateLabel,
                backgroundColor: AppColors.primaryFixed,
                foregroundColor: AppColors.primary,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              AppPill(
                icon: Icons.access_time_rounded,
                label: appointment.timeLabel,
              ),
              AppPill(
                icon: Icons.videocam_rounded,
                label: appointment.modeLabel,
              ),
              AppPill(
                icon: Icons.timelapse_rounded,
                label: appointment.doctor.durationLabel,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'Reschedule',
                  onPressed: onReschedule,
                  variant: AppButtonVariant.outline,
                  size: AppButtonSize.compact,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: AppButton(
                  label: 'Message',
                  onPressed: onOpenChat,
                  size: AppButtonSize.compact,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ConsultAgainCard extends StatelessWidget {
  const _ConsultAgainCard({required this.doctor, required this.onBookAgain});

  final DoctorProfileData doctor;
  final VoidCallback onBookAgain;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppAvatar(
                size: 44,
                imageUrl: doctor.imageUrl,
                radius: AppRadius.md,
                fallbackIcon: Icons.person_rounded,
              ),
              const Spacer(),
              AppPill(
                label: doctor.nextAvailableLabel.split(',').first,
                backgroundColor: AppColors.secondaryContainer.withValues(
                  alpha: 0.22,
                ),
                foregroundColor: AppColors.secondary,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            doctor.name,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            doctor.specialty,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: AppColors.onSurfaceVariant),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Last consultation completed successfully. Continue follow-up with the same doctor.',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.onSurfaceVariant,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          AppButton(
            label: 'Book Again',
            onPressed: onBookAgain,
            variant: AppButtonVariant.tonal,
            size: AppButtonSize.compact,
            height: 36,
          ),
        ],
      ),
    );
  }
}

class _PendingActionTile extends StatelessWidget {
  const _PendingActionTile({required this.item, required this.onTap});

  final _PendingActionItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppListRow(
      onTap: onTap,
      crossAxisAlignment: CrossAxisAlignment.start,
      leading: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        alignment: Alignment.center,
        child: Icon(item.icon, size: 18, color: AppColors.primary),
      ),
      title: Text(
        item.title,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: AppColors.onSurface,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        item.subtitle,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: AppColors.onSurfaceVariant,
          fontWeight: FontWeight.w500,
          height: 1.4,
        ),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AppPill(label: item.statusLabel),
          const SizedBox(height: AppSpacing.xs),
          const Icon(Icons.chevron_right_rounded, color: AppColors.outline),
        ],
      ),
    );
  }
}
