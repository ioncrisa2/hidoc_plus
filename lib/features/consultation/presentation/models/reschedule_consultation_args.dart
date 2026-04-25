import '../../../doctors/presentation/models/doctor_profile_data.dart';

class RescheduleConsultationArgs {
  const RescheduleConsultationArgs({
    required this.doctor,
    required this.currentDateLabel,
    required this.currentTimeLabel,
    required this.modeLabel,
    this.statusLabel = 'Confirmed',
  });

  final DoctorProfileData doctor;
  final String currentDateLabel;
  final String currentTimeLabel;
  final String modeLabel;
  final String statusLabel;
}
