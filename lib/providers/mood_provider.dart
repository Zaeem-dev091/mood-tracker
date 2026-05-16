import 'package:flutter/material.dart';
import '../models/mood_entry.dart';

class MoodProvider extends ChangeNotifier {
  final List<MoodEntry> _entries = [];
  Mood? _selectedMood;

  List<MoodEntry> get entries => List.unmodifiable(_entries);

  List<MoodEntry> get recentEntries {
    final sorted = [..._entries]..sort((a, b) => b.date.compareTo(a.date));
    return sorted.take(7).toList();
  }

  Mood? get selectedMood => _selectedMood;

  void selectMood(Mood mood) {
    _selectedMood = mood;
  }

  void logMood(Mood mood) {
    final entry = MoodEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      mood: mood,
      date: DateTime.now(),
    );
    _entries.add(entry);
    _selectedMood = null;
    notifyListeners();
  }

  void clearSelection() {
    _selectedMood = null;
    notifyListeners();
  }
}
