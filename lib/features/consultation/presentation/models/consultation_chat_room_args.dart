import 'package:flutter/material.dart';

class ConsultationChatRoomArgs {
  const ConsultationChatRoomArgs({
    required this.name,
    required this.timeLabel,
    this.imageUrl,
    this.initials,
    this.accentColor = const Color(0xFFE0E0FF),
    this.accentTextColor = const Color(0xFF525693),
    this.statusLabel = 'Online now',
  });

  final String name;
  final String timeLabel;
  final String? imageUrl;
  final String? initials;
  final Color accentColor;
  final Color accentTextColor;
  final String statusLabel;
}
