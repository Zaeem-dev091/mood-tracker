import 'package:flutter/material.dart';

enum Mood {
  happy,
  neutral,
  sad,
  excited,
  anxious,
}

extension MoodExtension on Mood {
  String get label {
    switch (this) {
      case Mood.happy:
        return 'Happy';
      case Mood.neutral:
        return 'Neutral';
      case Mood.sad:
        return 'Sad';
      case Mood.excited:
        return 'Excited';
      case Mood.anxious:
        return 'Anxious';
    }
  }

  Color get color {
    switch (this) {
      case Mood.happy:
        return const Color(0xFFFFC94A);
      case Mood.neutral:
        return const Color(0xFF7EC8E3);
      case Mood.sad:
        return const Color(0xFF8B9EBE);
      case Mood.excited:
        return const Color(0xFFFF7F7F);
      case Mood.anxious:
        return const Color(0xFFB39DDB);
    }
  }

  Color get lightColor {
    switch (this) {
      case Mood.happy:
        return const Color(0xFFFFF8E7);
      case Mood.neutral:
        return const Color(0xFFE8F6FB);
      case Mood.sad:
        return const Color(0xFFEEF1F7);
      case Mood.excited:
        return const Color(0xFFFFEEEE);
      case Mood.anxious:
        return const Color(0xFFF3F0FA);
    }
  }
}

class MoodEntry {
  final String id;
  final Mood mood;
  final DateTime date;
  final String? note;

  MoodEntry({
    required this.id,
    required this.mood,
    required this.date,
    this.note,
  });
}
