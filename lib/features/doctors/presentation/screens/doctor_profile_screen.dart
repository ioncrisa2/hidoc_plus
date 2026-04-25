import 'package:flutter/material.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../consultation/presentation/models/book_consultation_args.dart';
import '../../../dashboard/presentation/widgets/dashboard_section_top_bar.dart';
import '../models/doctor_profile_data.dart';
import '../widgets/doctor_profile_detail_tile.dart';
import '../widgets/doctor_profile_quick_book_tile.dart';
import '../widgets/doctor_profile_review_card.dart';
import '../widgets/doctor_profile_section_card.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key, required this.doctor});

  final DoctorProfileData doctor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: DashboardSectionTopBar(
        title: 'Doctor Profile',
        leadingIcon: Icons.arrow_back_rounded,
        trailingIcon: Icons.share_outlined,
        onLeadingTap: () => Navigator.of(context).maybePop(),
        onTrailingTap: () {},
      ),
      bottomNavigationBar: _DoctorProfileActionBar(doctor: doctor),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.md,
            AppSpacing.md,
            144,
          ),
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 448),
                child: Column(
                  children: [
                    _DoctorHeroCard(doctor: doctor),
                    const SizedBox(height: AppSpacing.lg),
                    DoctorProfileSectionCard(
                      title: 'CONSULTATION DETAILS',
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: AppSpacing.sm,
                        crossAxisSpacing: AppSpacing.sm,
                        childAspectRatio: 1.1,
                        children: [
                          DoctorProfileDetailTile(
                            icon: Icons.payments_outlined,
                            label: 'Fee',
                            value: doctor.feeLabel,
                          ),
                          DoctorProfileDetailTile(
                            icon: Icons.schedule_rounded,
                            label: 'Duration',
                            value: doctor.durationLabel,
                          ),
                          DoctorProfileDetailTile(
                            icon: Icons.video_call_outlined,
                            label: 'Available via',
                            value: doctor.availableViaLabel,
                          ),
                          DoctorProfileDetailTile(
                            icon: Icons.calendar_month_outlined,
                            label: 'Next available',
                            value: doctor.nextAvailableLabel,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    DoctorProfileSectionCard(
                      title: 'QUICK BOOK',
                      child: Column(
                        children: List.generate(doctor.quickBookSlots.length, (
                          index,
                        ) {
                          final slot = doctor.quickBookSlots[index];
                          final isLast =
                              index == doctor.quickBookSlots.length - 1;

                          return Column(
                            children: [
                              DoctorProfileQuickBookTile(
                                label: slot,
                                onTap: () {},
                              ),
                              if (!isLast)
                                const Divider(
                                  height: 0,
                                  color: AppColors.surfaceContainerLow,
                                ),
                            ],
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    DoctorProfileSectionCard(
                      title: 'ABOUT',
                      child: Text(
                        doctor.about,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.onSurfaceVariant,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    DoctorProfileSectionCard(
                      title: 'QUALIFICATIONS',
                      child: Column(
                        children: doctor.qualifications.map((item) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppSpacing.sm,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryContainer
                                        .withValues(alpha: 0.18),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    item.icon,
                                    size: 18,
                                    color: AppColors.secondary,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                Expanded(
                                  child: Text(
                                    item.label,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: AppColors.onSurface,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    DoctorProfileSectionCard(
                      title: 'EXPERTISE',
                      child: Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        children: doctor.expertise.map((item) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.xs,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryFixed,
                              borderRadius: BorderRadius.circular(
                                AppRadius.pill,
                              ),
                            ),
                            child: Text(
                              item,
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(
                                    color: AppColors.onSurface,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    DoctorProfileSectionCard(
                      title: 'PATIENT REVIEWS',
                      actionLabel: 'SEE ALL',
                      onAction: () {},
                      child: Column(
                        children: doctor.reviews.map((review) {
                          return DoctorProfileReviewCard(review: review);
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DoctorHeroCard extends StatelessWidget {
  const _DoctorHeroCard({required this.doctor});

  final DoctorProfileData doctor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.surfaceContainerHighest),
      ),
      child: Column(
        children: [
          Container(
            width: 104,
            height: 104,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.surfaceContainerHighest),
            ),
            child: ClipOval(
              child: Image.network(
                doctor.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.surfaceContainerLow,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.person_rounded,
                      size: 42,
                      color: AppColors.primary,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            doctor.name,
            style: textTheme.headlineSmall?.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            doctor.specialty,
            style: textTheme.titleMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryFixed,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.star_rounded,
                  color: AppColors.secondary,
                  size: 24,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  doctor.rating.toStringAsFixed(1),
                  style: textTheme.titleLarge?.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '(${doctor.reviewCount} reviews)',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            doctor.shortSummary,
            style: textTheme.bodyLarge?.copyWith(
              color: AppColors.onSurfaceVariant,
              height: 1.45,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _DoctorProfileActionBar extends StatelessWidget {
  const _DoctorProfileActionBar({required this.doctor});

  final DoctorProfileData doctor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.surfaceContainerHighest),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Align(
          alignment: Alignment.topCenter,
          heightFactor: 1,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 448),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                AppSpacing.xs,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppButton(
                    label: 'Book Appointment',
                    icon: Icons.calendar_month_outlined,
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.bookConsultation,
                        arguments: BookConsultationArgs(doctor: doctor),
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Message Clinic',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primary,
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
