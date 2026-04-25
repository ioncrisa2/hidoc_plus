import '../../../doctors/presentation/models/doctor_profile_data.dart';

class ConsultationVideoCallArgs {
  const ConsultationVideoCallArgs({
    required this.doctor,
    this.patientInitials = 'ER',
    this.appointmentLabel = 'Today, 10:30 AM',
    this.sessionTimerLabel = '08:24',
    this.connectionLabel = 'Secure HD',
    this.statusLabel = 'Doctor speaking',
    this.topicLabel = 'Cardiology follow-up',
    this.note =
        'We are reviewing your recent symptoms, blood pressure trend, and next treatment steps.',
  });

  final DoctorProfileData doctor;
  final String patientInitials;
  final String appointmentLabel;
  final String sessionTimerLabel;
  final String connectionLabel;
  final String statusLabel;
  final String topicLabel;
  final String note;
}
