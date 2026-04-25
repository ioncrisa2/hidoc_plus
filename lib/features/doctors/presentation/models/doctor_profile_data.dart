import 'package:flutter/material.dart';

enum DoctorCategory { generalPractitioner, specialist }

class DoctorProfileData {
  const DoctorProfileData({
    required this.name,
    required this.specialty,
    required this.specialtyTag,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.yearsExperience,
    required this.feeLabel,
    required this.durationLabel,
    required this.availableViaLabel,
    required this.nextAvailableLabel,
    required this.availabilityLabel,
    required this.about,
    required this.shortSummary,
    required this.category,
    required this.qualifications,
    required this.expertise,
    required this.quickBookSlots,
    required this.reviews,
    this.supportsVideoCall = false,
    this.isAvailableNow = false,
  });

  final String name;
  final String specialty;
  final String specialtyTag;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final int yearsExperience;
  final String feeLabel;
  final String durationLabel;
  final String availableViaLabel;
  final String nextAvailableLabel;
  final String availabilityLabel;
  final String about;
  final String shortSummary;
  final DoctorCategory category;
  final List<DoctorQualificationData> qualifications;
  final List<String> expertise;
  final List<String> quickBookSlots;
  final List<DoctorReviewData> reviews;
  final bool supportsVideoCall;
  final bool isAvailableNow;
}

class DoctorQualificationData {
  const DoctorQualificationData({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

class DoctorReviewData {
  const DoctorReviewData({
    required this.author,
    required this.timeLabel,
    required this.quote,
    required this.rating,
  });

  final String author;
  final String timeLabel;
  final String quote;
  final int rating;
}
