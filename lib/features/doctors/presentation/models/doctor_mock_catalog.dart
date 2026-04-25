import 'package:flutter/material.dart';

import 'doctor_profile_data.dart';

abstract final class DoctorMockCatalog {
  static const doctors = <DoctorProfileData>[
    DoctorProfileData(
      name: 'Dr. Elena Rodriguez',
      specialty: 'Senior Cardiologist',
      specialtyTag: 'Cardiology',
      imageUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
      rating: 4.9,
      reviewCount: 128,
      yearsExperience: 12,
      feeLabel: '\$50',
      durationLabel: '20-30 min',
      availableViaLabel: 'Video, Audio, Chat',
      nextAvailableLabel: 'Today, 4:30 PM',
      availabilityLabel: 'Today, 4:30 PM',
      shortSummary: 'Heart specialist with 12+ years of clinical experience',
      about:
          'Dr. Elena Rodriguez is a board-certified cardiologist with over a decade of experience in diagnosing and treating cardiovascular diseases. She is dedicated to providing compassionate, patient-centered care and specializes in preventive cardiology and heart failure management.',
      category: DoctorCategory.specialist,
      supportsVideoCall: true,
      isAvailableNow: true,
      qualifications: [
        DoctorQualificationData(
          label: 'MD Internal Medicine',
          icon: Icons.school_rounded,
        ),
        DoctorQualificationData(
          label: 'Fellowship in Cardiology',
          icon: Icons.verified_rounded,
        ),
        DoctorQualificationData(
          label: 'Board Certified Cardiologist',
          icon: Icons.workspace_premium_rounded,
        ),
      ],
      expertise: [
        'Hypertension',
        'Arrhythmia',
        'Chest Pain Evaluation',
        'Echocardiogram',
      ],
      quickBookSlots: [
        'Today - 4:30 PM',
        'Tomorrow - 2:15 PM',
        'Friday - 10:00 AM',
      ],
      reviews: [
        DoctorReviewData(
          author: 'Sarah M.',
          timeLabel: '2 weeks ago',
          quote:
              'Dr. Rodriguez was incredibly thorough and took the time to explain all my test results in a way I could understand. Highly recommend her!',
          rating: 5,
        ),
      ],
    ),
    DoctorProfileData(
      name: 'Dr. Marcus Chen',
      specialty: 'Interventional Cardiologist',
      specialtyTag: 'Cardiology',
      imageUrl: 'https://randomuser.me/api/portraits/men/54.jpg',
      rating: 4.8,
      reviewCount: 96,
      yearsExperience: 8,
      feeLabel: '\$65',
      durationLabel: '25-35 min',
      availableViaLabel: 'Video, Chat',
      nextAvailableLabel: 'Tomorrow, 9:00 AM',
      availabilityLabel: 'Tomorrow, 9:00 AM',
      shortSummary:
          'Interventional cardiology specialist focused on minimally invasive cardiac care',
      about:
          'Dr. Marcus Chen focuses on minimally invasive procedures for cardiovascular conditions and helps patients navigate treatment with clear, evidence-based guidance. He has extensive experience in angioplasty and complex coronary care.',
      category: DoctorCategory.specialist,
      supportsVideoCall: true,
      qualifications: [
        DoctorQualificationData(
          label: 'MD Cardiovascular Medicine',
          icon: Icons.school_rounded,
        ),
        DoctorQualificationData(
          label: 'Interventional Cardiology Fellowship',
          icon: Icons.verified_rounded,
        ),
        DoctorQualificationData(
          label: 'Accredited Cath Lab Specialist',
          icon: Icons.workspace_premium_rounded,
        ),
      ],
      expertise: [
        'Coronary Angioplasty',
        'Chest Pain',
        'Heart Screening',
        'Preventive Cardiology',
      ],
      quickBookSlots: [
        'Tomorrow - 9:00 AM',
        'Thursday - 1:45 PM',
        'Saturday - 11:30 AM',
      ],
      reviews: [
        DoctorReviewData(
          author: 'Michael T.',
          timeLabel: '1 month ago',
          quote:
              'Very clear explanations and a calm approach during consultation. I felt confident about the next treatment steps.',
          rating: 5,
        ),
      ],
    ),
    DoctorProfileData(
      name: 'Dr. Amelia Foster',
      specialty: 'General Practitioner',
      specialtyTag: 'Dermatology',
      imageUrl: 'https://randomuser.me/api/portraits/women/68.jpg',
      rating: 4.7,
      reviewCount: 74,
      yearsExperience: 10,
      feeLabel: '\$38',
      durationLabel: '15-20 min',
      availableViaLabel: 'Video, Chat',
      nextAvailableLabel: 'Today, 6:00 PM',
      availabilityLabel: 'Today, 6:00 PM',
      shortSummary:
          'Primary care physician with a strong focus on preventative and family medicine',
      about:
          'Dr. Amelia Foster provides holistic primary care for adults and families, helping patients manage routine health concerns, screening needs, and ongoing wellness goals with a practical and empathetic approach.',
      category: DoctorCategory.generalPractitioner,
      isAvailableNow: true,
      qualifications: [
        DoctorQualificationData(
          label: 'MD Family Medicine',
          icon: Icons.school_rounded,
        ),
        DoctorQualificationData(
          label: 'Preventive Care Certification',
          icon: Icons.verified_rounded,
        ),
        DoctorQualificationData(
          label:
              'Women'
              's Health Training',
          icon: Icons.workspace_premium_rounded,
        ),
      ],
      expertise: [
        'Routine Checkup',
        'Vaccination',
        'Women'
            's Health',
        'Preventive Screening',
      ],
      quickBookSlots: [
        'Today - 6:00 PM',
        'Tomorrow - 11:15 AM',
        'Friday - 3:45 PM',
      ],
      reviews: [
        DoctorReviewData(
          author: 'Nadia R.',
          timeLabel: '3 weeks ago',
          quote:
              'Warm, practical, and very attentive. The consultation felt efficient without being rushed.',
          rating: 5,
        ),
      ],
    ),
    DoctorProfileData(
      name: 'Dr. Noah Patel',
      specialty: 'Neurology Consultant',
      specialtyTag: 'Neurology',
      imageUrl: 'https://randomuser.me/api/portraits/men/79.jpg',
      rating: 4.6,
      reviewCount: 61,
      yearsExperience: 9,
      feeLabel: '\$58',
      durationLabel: '25-30 min',
      availableViaLabel: 'Video, Audio',
      nextAvailableLabel: 'Friday, 1:30 PM',
      availabilityLabel: 'Friday, 1:30 PM',
      shortSummary:
          'Neurology consultant experienced in headache, nerve, and cognitive care',
      about:
          'Dr. Noah Patel manages neurological symptoms including migraines, neuropathy, and cognitive concerns. He works closely with patients to translate complex findings into understandable treatment plans.',
      category: DoctorCategory.specialist,
      supportsVideoCall: true,
      qualifications: [
        DoctorQualificationData(
          label: 'MD Neurology',
          icon: Icons.school_rounded,
        ),
        DoctorQualificationData(
          label: 'Clinical Neurophysiology Training',
          icon: Icons.verified_rounded,
        ),
        DoctorQualificationData(
          label: 'Board Certified Neurologist',
          icon: Icons.workspace_premium_rounded,
        ),
      ],
      expertise: [
        'Migraine',
        'Neuropathy',
        'Sleep Neurology',
        'Cognitive Evaluation',
      ],
      quickBookSlots: [
        'Friday - 1:30 PM',
        'Saturday - 9:30 AM',
        'Monday - 4:00 PM',
      ],
      reviews: [
        DoctorReviewData(
          author: 'Jason P.',
          timeLabel: '1 week ago',
          quote:
              'Dr. Patel was patient and methodical. I finally understood the cause of my symptoms and next steps.',
          rating: 4,
        ),
      ],
    ),
  ];
}
