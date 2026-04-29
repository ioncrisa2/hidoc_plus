import 'package:flutter/material.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../consultation/presentation/models/book_consultation_args.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../dashboard/presentation/widgets/dashboard_section_top_bar.dart';
import '../models/doctor_mock_catalog.dart';
import '../models/doctor_profile_data.dart';
import '../widgets/find_doctors_result_card.dart';
import '../widgets/find_doctors_search_field.dart';

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
  static const _allSpecialtiesLabel = 'All Specialties';
  static const _allFiltersLabel = 'All Filters';

  final TextEditingController _searchController = TextEditingController();
  DoctorCategory _selectedCategory = DoctorCategory.specialist;
  String _selectedSpecialty = 'Cardiology';
  String _selectedMetaFilter = _allFiltersLabel;

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

      if (_selectedSpecialty != _allSpecialtiesLabel &&
          doctor.specialtyTag != _selectedSpecialty) {
        return false;
      }

      if (_selectedMetaFilter == 'Available Now' && !doctor.isAvailableNow) {
        return false;
      }

      if (_selectedMetaFilter == '4.5+ Rating' && doctor.rating < 4.5) {
        return false;
      }

      if (_selectedMetaFilter == 'Video Call' && !doctor.supportsVideoCall) {
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
                _CompactFilterDropdown<DoctorCategory>(
                  value: _selectedCategory,
                  icon: Icons.person_search_outlined,
                  items: DoctorCategory.values,
                  labelBuilder: _labelForCategory,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }

                    setState(() => _selectedCategory = value);
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: _CompactFilterDropdown<String>(
                        value: _selectedSpecialty,
                        icon: Icons.medical_services_outlined,
                        items: const [
                          _allSpecialtiesLabel,
                          ..._specialtyFilters,
                        ],
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }

                          setState(() => _selectedSpecialty = value);
                        },
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: _CompactFilterDropdown<String>(
                        value: _selectedMetaFilter,
                        icon: Icons.tune_rounded,
                        items: const [_allFiltersLabel, ..._metaFilters],
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }

                          setState(() => _selectedMetaFilter = value);
                        },
                      ),
                    ),
                  ],
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

  String _labelForCategory(DoctorCategory category) {
    switch (category) {
      case DoctorCategory.generalPractitioner:
        return 'General Practitioner';
      case DoctorCategory.specialist:
        return 'Specialist';
    }
  }
}

class _CompactFilterDropdown<T> extends StatelessWidget {
  const _CompactFilterDropdown({
    required this.value,
    required this.icon,
    required this.items,
    required this.onChanged,
    this.labelBuilder,
  });

  final T value;
  final IconData icon;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String Function(T value)? labelBuilder;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: Icon(icon, size: 17, color: AppColors.onSurfaceVariant),
        prefixIconConstraints: const BoxConstraints(minWidth: 36),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: AppSpacing.xs + 2,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          borderSide: const BorderSide(color: AppColors.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          borderSide: const BorderSide(color: AppColors.primaryContainer),
        ),
      ),
      borderRadius: BorderRadius.circular(AppRadius.md),
      dropdownColor: AppColors.surface,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: AppColors.onSurface,
        fontWeight: FontWeight.w700,
      ),
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(_labelFor(item), overflow: TextOverflow.ellipsis),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  String _labelFor(T value) {
    final builder = labelBuilder;
    if (builder != null) {
      return builder(value);
    }

    return value.toString();
  }
}
