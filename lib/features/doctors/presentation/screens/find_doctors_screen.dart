import 'package:flutter/material.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../consultation/presentation/models/book_consultation_args.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../dashboard/presentation/widgets/dashboard_section_top_bar.dart';
import '../models/doctor_mock_catalog.dart';
import '../models/doctor_profile_data.dart';
import '../widgets/find_doctors_filter_chip.dart';
import '../widgets/find_doctors_result_card.dart';
import '../widgets/find_doctors_search_field.dart';
import '../widgets/find_doctors_segmented_toggle.dart';

class FindDoctorsScreen extends StatefulWidget {
  const FindDoctorsScreen({super.key});

  @override
  State<FindDoctorsScreen> createState() => _FindDoctorsScreenState();
}

class _FindDoctorsScreenState extends State<FindDoctorsScreen> {
  static const _specialtyFilters = <String>[
    'Cardiology',
    'Dermatology',
    'Neurology',
  ];

  static const _metaFilters = <String>[
    'Available Now',
    '4.5+ Rating',
    'Video Call',
  ];

  final TextEditingController _searchController = TextEditingController();
  DoctorCategory _selectedCategory = DoctorCategory.specialist;
  final Set<String> _selectedSpecialties = {'Cardiology'};
  final Set<String> _selectedMetaFilters = {};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<DoctorProfileData> get _filteredDoctors {
    final query = _searchController.text.trim().toLowerCase();

    return DoctorMockCatalog.doctors.where((doctor) {
      if (doctor.category != _selectedCategory) {
        return false;
      }

      if (_selectedSpecialties.isNotEmpty &&
          !_selectedSpecialties.contains(doctor.specialtyTag)) {
        return false;
      }

      if (_selectedMetaFilters.contains('Available Now') &&
          !doctor.isAvailableNow) {
        return false;
      }

      if (_selectedMetaFilters.contains('4.5+ Rating') && doctor.rating < 4.5) {
        return false;
      }

      if (_selectedMetaFilters.contains('Video Call') &&
          !doctor.supportsVideoCall) {
        return false;
      }

      if (query.isEmpty) {
        return true;
      }

      return doctor.name.toLowerCase().contains(query) ||
          doctor.specialty.toLowerCase().contains(query) ||
          doctor.specialtyTag.toLowerCase().contains(query);
    }).toList();
  }

  void _toggleSpecialty(String value) {
    setState(() {
      if (_selectedSpecialties.contains(value)) {
        _selectedSpecialties.remove(value);
        return;
      }

      _selectedSpecialties.add(value);
    });
  }

  void _toggleMetaFilter(String value) {
    setState(() {
      if (_selectedMetaFilters.contains(value)) {
        _selectedMetaFilters.remove(value);
        return;
      }

      _selectedMetaFilters.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final doctors = _filteredDoctors;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: DashboardSectionTopBar(
        title: 'Find Doctors',
        leadingIcon: Icons.arrow_back_rounded,
        onLeadingTap: () => Navigator.of(context).maybePop(),
      ),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 448),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.xl,
              ),
              children: [
                FindDoctorsSearchField(
                  controller: _searchController,
                  hintText: 'Search doctor, specialty...',
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: AppSpacing.sm),
                FindDoctorsSegmentedToggle(
                  leftLabel: 'General Practitioner',
                  rightLabel: 'Specialist',
                  selectedValue: _selectedCategory,
                  leftValue: DoctorCategory.generalPractitioner,
                  rightValue: DoctorCategory.specialist,
                  onChanged: (value) =>
                      setState(() => _selectedCategory = value),
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: _specialtyFilters.map((filter) {
                    return FindDoctorsFilterChip(
                      label: filter,
                      icon: _iconForSpecialty(filter),
                      isSelected: _selectedSpecialties.contains(filter),
                      onTap: () => _toggleSpecialty(filter),
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSpacing.xs),
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: _metaFilters.map((filter) {
                    return FindDoctorsFilterChip(
                      label: filter,
                      icon: _iconForMeta(filter),
                      isSelected: _selectedMetaFilters.contains(filter),
                      selectedBackgroundColor: AppColors.surfaceContainerLow,
                      selectedForegroundColor: AppColors.onSurface,
                      onTap: () => _toggleMetaFilter(filter),
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSpacing.md),
                ...doctors.map((doctor) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: FindDoctorsResultCard(
                      imageUrl: doctor.imageUrl,
                      name: doctor.name,
                      specialty: doctor.specialty,
                      rating: doctor.rating,
                      yearsExperience: doctor.yearsExperience,
                      availabilityLabel: doctor.availabilityLabel,
                      feeLabel: '${doctor.feeLabel} / session',
                      onViewProfile: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.doctorProfile,
                          arguments: doctor,
                        );
                      },
                      onBookNow: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.bookConsultation,
                          arguments: BookConsultationArgs(doctor: doctor),
                        );
                      },
                    ),
                  );
                }),
                if (doctors.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.xl),
                    child: Center(
                      child: Text(
                        'No doctors match your current filters.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _iconForSpecialty(String label) {
    switch (label) {
      case 'Cardiology':
        return Icons.favorite_rounded;
      case 'Dermatology':
        return Icons.spa_outlined;
      case 'Neurology':
        return Icons.psychology_alt_outlined;
      default:
        return Icons.local_hospital_outlined;
    }
  }

  IconData _iconForMeta(String label) {
    switch (label) {
      case 'Available Now':
        return Icons.access_time_filled_rounded;
      case '4.5+ Rating':
        return Icons.star_rounded;
      case 'Video Call':
        return Icons.videocam_rounded;
      default:
        return Icons.tune_rounded;
    }
  }
}
