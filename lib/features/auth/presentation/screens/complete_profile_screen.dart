import 'package:flutter/material.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_pill.dart';
import '../../../../core/widgets/app_surface_card.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../widgets/auth_headline.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_shell.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _addressController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _allergyNotesController = TextEditingController();
  final _chronicConditionsController = TextEditingController();
  final _routineMedicationController = TextEditingController();

  String _selectedBloodType = 'O+';
  String _selectedGender = 'Female';
  DateTime? _selectedBirthDate;
  bool _hasDrugAllergy = false;

  static const _bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  static const _genderOptions = ['Male', 'Female'];

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _birthDateController.dispose();
    _addressController.dispose();
    _emergencyContactController.dispose();
    _allergyNotesController.dispose();
    _chronicConditionsController.dispose();
    _routineMedicationController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
  }

  Future<void> _openBirthDatePicker() async {
    final now = DateTime.now();
    var draftDate = _selectedBirthDate ?? DateTime(now.year - 25, 1, 1);

    final selectedDate = await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      builder: (context) {
        return SafeArea(
          child: StatefulBuilder(
            builder: (context, setSheetState) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.md,
                  AppSpacing.md,
                  AppSpacing.lg,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.outlineVariant,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'Select date of birth',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Choose the year first, then month and date.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    CalendarDatePicker(
                      initialDate: draftDate,
                      firstDate: DateTime(1900),
                      lastDate: now,
                      initialCalendarMode: DatePickerMode.year,
                      onDateChanged: (value) {
                        setSheetState(() => draftDate = value);
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            label: 'Cancel',
                            onPressed: () => Navigator.pop(context),
                            variant: AppButtonVariant.outline,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: AppButton(
                            label: 'Use Date',
                            onPressed: () => Navigator.pop(context, draftDate),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );

    if (selectedDate == null) {
      return;
    }

    setState(() {
      _selectedBirthDate = selectedDate;
      _birthDateController.text = _formatBirthDate(selectedDate);
    });
  }

  String _formatBirthDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');

    return '$day/$month/${date.year}';
  }

  String? _validateOptionalNumber({
    required String? value,
    required String label,
    required double min,
    required double max,
  }) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return null;
    }

    final parsed = double.tryParse(trimmed);
    if (parsed == null) {
      return 'Use numbers only.';
    }

    if (parsed < min || parsed > max) {
      return '$label should be between ${min.toStringAsFixed(0)} and ${max.toStringAsFixed(0)}.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AuthShell(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AuthLogo(height: 56),
            const SizedBox(height: AppSpacing.xl),
            const AuthHeadline(
              title: 'Complete your health profile',
              subtitle:
                  'Add key medical details so consultations, bookings, and emergency support can be prepared correctly.',
            ),
            const SizedBox(height: AppSpacing.lg),
            AppSurfaceCard(
              backgroundColor: AppColors.surfaceContainerLow,
              borderColor: AppColors.surfaceContainerHighest,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.primaryFixed,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: const Icon(
                      Icons.health_and_safety_outlined,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'These details are used as baseline medical context. You can update them later from your profile.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.onSurfaceVariant,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _ProfileDropdownField(
              label: 'Blood Type',
              value: _selectedBloodType,
              icon: Icons.bloodtype_outlined,
              items: _bloodTypes,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                setState(() => _selectedBloodType = value);
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    label: 'Weight (optional)',
                    hintText: 'kg',
                    controller: _weightController,
                    prefixIcon: Icons.monitor_weight_outlined,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: (value) => _validateOptionalNumber(
                      value: value,
                      label: 'Weight',
                      min: 2,
                      max: 350,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: AppTextField(
                    label: 'Height (optional)',
                    hintText: 'cm',
                    controller: _heightController,
                    prefixIcon: Icons.height_rounded,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: (value) => _validateOptionalNumber(
                      value: value,
                      label: 'Height',
                      min: 40,
                      max: 250,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              label: 'Date of birth',
              hintText: 'DD/MM/YYYY',
              controller: _birthDateController,
              prefixIcon: Icons.cake_outlined,
              keyboardType: TextInputType.datetime,
              textInputAction: TextInputAction.next,
              readOnly: true,
              onTap: _openBirthDatePicker,
              suffixIcon: IconButton(
                onPressed: _openBirthDatePicker,
                icon: const Icon(
                  Icons.calendar_month_outlined,
                  color: AppColors.outline,
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Date of birth is required.';
                }
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.md),
            _ProfileDropdownField(
              label: 'Gender',
              value: _selectedGender,
              icon: Icons.wc_outlined,
              items: _genderOptions,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                setState(() => _selectedGender = value);
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            AppSurfaceCard(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Drug Allergy',
                          style: textTheme.titleMedium?.copyWith(
                            color: AppColors.onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Switch(
                        value: _hasDrugAllergy,
                        activeThumbColor: AppColors.primaryContainer,
                        onChanged: (value) {
                          setState(() => _hasDrugAllergy = value);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  AppPill(
                    icon: _hasDrugAllergy
                        ? Icons.warning_amber_rounded
                        : Icons.check_circle_outline_rounded,
                    label: _hasDrugAllergy
                        ? 'Allergy details needed'
                        : 'No known drug allergy',
                    backgroundColor: _hasDrugAllergy
                        ? AppColors.errorContainer
                        : AppColors.secondaryContainer.withValues(alpha: 0.22),
                    foregroundColor: _hasDrugAllergy
                        ? AppColors.onErrorContainer
                        : AppColors.secondary,
                  ),
                  if (_hasDrugAllergy) ...[
                    const SizedBox(height: AppSpacing.md),
                    AppTextField(
                      label: 'Allergy notes',
                      hintText: 'Example: amoxicillin, ibuprofen',
                      controller: _allergyNotesController,
                      prefixIcon: Icons.medication_liquid_outlined,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (!_hasDrugAllergy) {
                          return null;
                        }
                        if (value == null || value.trim().isEmpty) {
                          return 'Add the medicine allergy details.';
                        }
                        return null;
                      },
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Recommended Details',
              style: textTheme.titleLarge?.copyWith(
                color: AppColors.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Optional now, useful for doctors before consultation.',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              label: 'Address (optional)',
              hintText: 'Home address for pharmacy delivery',
              controller: _addressController,
              prefixIcon: Icons.home_outlined,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              label: 'Emergency contact',
              hintText: 'Name and phone number',
              controller: _emergencyContactController,
              prefixIcon: Icons.contact_phone_outlined,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              label: 'Chronic conditions',
              hintText: 'Example: asthma, diabetes, hypertension',
              controller: _chronicConditionsController,
              prefixIcon: Icons.medical_information_outlined,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              label: 'Routine medication',
              hintText: 'Example: metformin 500mg',
              controller: _routineMedicationController,
              prefixIcon: Icons.medication_outlined,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: 'Save & Continue',
              icon: Icons.arrow_forward_rounded,
              onPressed: _submit,
            ),
            const SizedBox(height: AppSpacing.sm),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
                },
                child: const Text('Skip for now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileDropdownField extends StatelessWidget {
  const _ProfileDropdownField({
    required this.label,
    required this.value,
    required this.icon,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final String value;
  final IconData icon;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: textTheme.labelMedium),
        const SizedBox(height: AppSpacing.xs),
        DropdownButtonFormField<String>(
          initialValue: value,
          items: items
              .map(
                (item) =>
                    DropdownMenuItem<String>(value: item, child: Text(item)),
              )
              .toList(),
          onChanged: onChanged,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.outline,
          ),
          style: textTheme.bodyLarge?.copyWith(color: AppColors.textPrimary),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.outline, size: 20),
          ),
          borderRadius: BorderRadius.circular(AppRadius.md),
          dropdownColor: AppColors.surface,
        ),
      ],
    );
  }
}
