import '../../../doctors/presentation/models/doctor_profile_data.dart';

class BookConsultationArgs {
  const BookConsultationArgs({
    required this.doctor,
    this.slotLabel,
    this.modeLabel,
  });

  final DoctorProfileData doctor;
  final String? slotLabel;
  final String? modeLabel;
}
