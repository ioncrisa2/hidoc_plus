import '../../../doctors/presentation/models/doctor_profile_data.dart';

class BookingConfirmationArgs {
  const BookingConfirmationArgs({
    required this.doctor,
    required this.dateLabel,
    required this.timeLabel,
    required this.durationLabel,
    required this.modeLabel,
    required this.paymentMethodLabel,
    required this.totalPaid,
  });

  final DoctorProfileData doctor;
  final String dateLabel;
  final String timeLabel;
  final String durationLabel;
  final String modeLabel;
  final String paymentMethodLabel;
  final double totalPaid;
}
