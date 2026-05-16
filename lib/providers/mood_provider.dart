import 'package:flutter/material.dart';
import '../models/mood_entry.dart';

class MoodProvider extends ChangeNotifier {
  final List<MoodEntry> _entries = [];

  List<MoodEntry> get recentEntries {
    final sorted = [..._entries]..sort((a, b) => b.date.compareTo(a.date));
    return sorted.take(7).toList();
  }

  void logMood(Mood mood) {
    final entry = MoodEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      mood: mood,
      date: DateTime.now(),
    );
    _entries.add(entry);
    notifyListeners();
  }
}
