import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hidoc_plus/app/app.dart';
import 'package:hidoc_plus/features/auth/presentation/screens/welcome_screen.dart';
import 'package:hidoc_plus/features/doctors/presentation/models/doctor_mock_catalog.dart';
import 'package:hidoc_plus/features/doctors/presentation/screens/doctor_profile_screen.dart';

void main() {
  testWidgets('renders welcome screen', (WidgetTester tester) async {
    await tester.pumpWidget(const HiDocApp());

    expect(find.byType(WelcomeScreen), findsOneWidget);
  });

  testWidgets('renders doctor profile content', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DoctorProfileScreen(doctor: DoctorMockCatalog.doctors.first),
      ),
    );

    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    expect(find.text('Doctor Profile'), findsOneWidget);
    expect(find.text('Dr. Elena Rodriguez'), findsOneWidget);
    expect(find.text('CONSULTATION DETAILS'), findsOneWidget);
    expect(find.text('Book Appointment'), findsOneWidget);
  });
}
