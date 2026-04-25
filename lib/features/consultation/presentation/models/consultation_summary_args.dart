import 'package:flutter/material.dart';

import '../../../doctors/presentation/models/doctor_profile_data.dart';

enum ConsultationSummaryActionType {
  scheduleFollowUp,
  bookNewConsultation,
  orderMedicines,
}

class ConsultationSummaryMedicine {
  const ConsultationSummaryMedicine({
    required this.name,
    required this.dose,
    required this.schedule,
    required this.quantityLabel,
    this.icon = Icons.medication_outlined,
    this.iconBackgroundColor,
    this.iconColor,
  });

  final String name;
  final String dose;
  final String schedule;
  final String quantityLabel;
  final IconData icon;
  final Color? iconBackgroundColor;
  final Color? iconColor;
}

class ConsultationSummaryArgs {
  const ConsultationSummaryArgs({
    required this.doctor,
    required this.dateTimeLabel,
    required this.visitSummaryBullets,
    required this.primaryAction,
    required this.secondaryAction,
    this.showFollowUpBadge = false,
    this.summaryOverview,
    this.diagnosisBullets = const [],
    this.outcomeMessage,
    this.recommendedActionTitle,
    this.recommendedActionMessage,
    this.prescribedMedicines = const [],
    this.prescriptionNotice,
  });

  final DoctorProfileData doctor;
  final String dateTimeLabel;
  final bool showFollowUpBadge;
  final String? summaryOverview;
  final List<String> visitSummaryBullets;
  final List<String> diagnosisBullets;
  final String? outcomeMessage;
  final String? recommendedActionTitle;
  final String? recommendedActionMessage;
  final List<ConsultationSummaryMedicine> prescribedMedicines;
  final String? prescriptionNotice;
  final ConsultationSummaryActionType primaryAction;
  final ConsultationSummaryActionType secondaryAction;
}

extension ConsultationSummaryActionTypeX on ConsultationSummaryActionType {
  String get label {
    switch (this) {
      case ConsultationSummaryActionType.scheduleFollowUp:
        return 'Schedule Follow-up';
      case ConsultationSummaryActionType.bookNewConsultation:
        return 'Book New Consultation';
      case ConsultationSummaryActionType.orderMedicines:
        return 'Order Medicines';
    }
  }

  IconData get icon {
    switch (this) {
      case ConsultationSummaryActionType.scheduleFollowUp:
        return Icons.event_available_rounded;
      case ConsultationSummaryActionType.bookNewConsultation:
        return Icons.add_circle_outline_rounded;
      case ConsultationSummaryActionType.orderMedicines:
        return Icons.local_pharmacy_outlined;
    }
  }
}
