import 'package:flutter/material.dart';

import '../../features/auth/presentation/screens/complete_profile_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/consultation/presentation/models/book_consultation_args.dart';
import '../../features/consultation/presentation/models/booking_confirmation_args.dart';
import '../../features/consultation/presentation/models/consultation_chat_room_args.dart';
import '../../features/consultation/presentation/models/consultation_summary_args.dart';
import '../../features/consultation/presentation/models/consultation_video_call_args.dart';
import '../../features/consultation/presentation/models/reschedule_consultation_args.dart';
import '../../features/consultation/presentation/screens/book_consultation_screen.dart';
import '../../features/consultation/presentation/screens/consultation_chat_room_screen.dart';
import '../../features/consultation/presentation/screens/consultation_messages_screen.dart';
import '../../features/consultation/presentation/screens/consultation_payment_success_screen.dart';
import '../../features/consultation/presentation/screens/consultation_summary_screen.dart';
import '../../features/consultation/presentation/screens/consultation_video_call_screen.dart';
import '../../features/consultation/presentation/screens/reschedule_consultation_screen.dart';
import '../../features/consultation/presentation/screens/consultation_hub_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/welcome_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/doctors/presentation/models/doctor_mock_catalog.dart';
import '../../features/doctors/presentation/models/doctor_profile_data.dart';
import '../../features/doctors/presentation/screens/doctor_profile_screen.dart';
import '../../features/doctors/presentation/screens/find_doctors_screen.dart';
import '../../features/notifications/presentation/screens/notification_hub_screen.dart';
import '../../features/search/presentation/screens/search_hub_screen.dart';
import 'app_routes.dart';

abstract final class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.welcome:
        return _buildRoute(
          settings: settings,
          builder: (_) => const WelcomeScreen(),
        );
      case AppRoutes.login:
        return _buildRoute(
          settings: settings,
          builder: (_) => const LoginScreen(),
        );
      case AppRoutes.register:
        return _buildRoute(
          settings: settings,
          builder: (_) => const RegisterScreen(),
        );
      case AppRoutes.completeProfile:
        return _buildRoute(
          settings: settings,
          builder: (_) => const CompleteProfileScreen(),
        );
      case AppRoutes.dashboard:
        return _buildRoute(
          settings: settings,
          builder: (_) => const DashboardScreen(),
        );
      case AppRoutes.searchHub:
        return _buildRoute(
          settings: settings,
          builder: (_) => const SearchHubScreen(),
        );
      case AppRoutes.notificationHub:
        return _buildRoute(
          settings: settings,
          builder: (_) => const NotificationHubScreen(),
        );
      case AppRoutes.consultationHub:
        return _buildRoute(
          settings: settings,
          builder: (_) => const ConsultationHubScreen(),
        );
      case AppRoutes.consultationSummary:
        final args = settings.arguments;
        return _buildRoute(
          settings: settings,
          builder: (_) => ConsultationSummaryScreen(
            args: args is ConsultationSummaryArgs
                ? args
                : ConsultationSummaryArgs(
                    doctor: DoctorMockCatalog.doctors.first,
                    dateTimeLabel: 'Oct 24, 2023 • 10:30 AM',
                    visitSummaryBullets: const [
                      'Reviewed current symptoms and recent blood pressure trend.',
                      'No urgent warning signs were identified during the consultation.',
                    ],
                    outcomeMessage:
                        'No medicine was prescribed during this consultation.',
                    recommendedActionTitle: 'Cardiac Stress Test',
                    recommendedActionMessage:
                        'To further evaluate exercise-related palpitations, complete a supervised stress test within the next 1-2 weeks.',
                    primaryAction:
                        ConsultationSummaryActionType.scheduleFollowUp,
                    secondaryAction:
                        ConsultationSummaryActionType.bookNewConsultation,
                  ),
          ),
        );
      case AppRoutes.consultationVideoCall:
        final args = settings.arguments;
        return _buildRoute(
          settings: settings,
          builder: (_) => ConsultationVideoCallScreen(
            args: args is ConsultationVideoCallArgs
                ? args
                : ConsultationVideoCallArgs(
                    doctor: DoctorMockCatalog.doctors.first,
                    appointmentLabel: 'Today, 10:30 AM',
                    sessionTimerLabel: '08:24',
                    topicLabel: 'Heart rhythm review',
                    note:
                        'We are reviewing your recent ECG summary, symptom changes, and the next medication plan.',
                  ),
          ),
        );
      case AppRoutes.consultationMessages:
        return _buildRoute(
          settings: settings,
          builder: (_) => const ConsultationMessagesScreen(),
        );
      case AppRoutes.consultationChatRoom:
        final args = settings.arguments;
        return _buildRoute(
          settings: settings,
          builder: (_) => ConsultationChatRoomScreen(
            args: args is ConsultationChatRoomArgs
                ? args
                : const ConsultationChatRoomArgs(
                    name: 'Dr. Elena Rodriguez',
                    timeLabel: 'Tue',
                    initials: 'ER',
                  ),
          ),
        );
      case AppRoutes.rescheduleConsultation:
        final args = settings.arguments;
        return _buildRoute(
          settings: settings,
          builder: (_) => RescheduleConsultationScreen(
            args: args is RescheduleConsultationArgs
                ? args
                : RescheduleConsultationArgs(
                    doctor: DoctorMockCatalog.doctors.first,
                    currentDateLabel: 'Oct 24',
                    currentTimeLabel: '10:30 AM',
                    modeLabel: 'Video Call',
                  ),
          ),
        );
      case AppRoutes.bookConsultation:
        final args = settings.arguments;
        return _buildRoute(
          settings: settings,
          builder: (_) => BookConsultationScreen(
            args: args is BookConsultationArgs
                ? args
                : BookConsultationArgs(doctor: DoctorMockCatalog.doctors.first),
          ),
        );
      case AppRoutes.consultationPaymentSuccess:
        final args = settings.arguments;
        return _buildRoute(
          settings: settings,
          builder: (_) => ConsultationPaymentSuccessScreen(
            args: args is BookingConfirmationArgs
                ? args
                : BookingConfirmationArgs(
                    doctor: DoctorMockCatalog.doctors.first,
                    dateLabel: 'Today',
                    timeLabel: '4:30 PM',
                    durationLabel: '20-30 min',
                    modeLabel: 'Video Consultation',
                    paymentMethodLabel: 'Credit / Debit Card',
                    totalPaid: 52,
                  ),
          ),
        );
      case AppRoutes.findDoctors:
        return _buildRoute(
          settings: settings,
          builder: (_) => const FindDoctorsScreen(),
        );
      case AppRoutes.doctorProfile:
        final doctor = settings.arguments;
        return _buildRoute(
          settings: settings,
          builder: (_) => DoctorProfileScreen(
            doctor: doctor is DoctorProfileData
                ? doctor
                : DoctorMockCatalog.doctors.first,
          ),
        );
      default:
        return _buildRoute(
          settings: settings,
          builder: (_) => const WelcomeScreen(),
        );
    }
  }

  static PageRoute<void> _buildRoute({
    required RouteSettings settings,
    required WidgetBuilder builder,
  }) {
    return MaterialPageRoute<void>(settings: settings, builder: builder);
  }
}
