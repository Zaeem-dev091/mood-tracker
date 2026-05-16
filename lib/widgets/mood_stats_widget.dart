import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/mood_entry.dart';
import '../providers/mood_provider.dart';

class MoodStatsWidget extends StatelessWidget {
  const MoodStatsWidget({super.key});

  Mood? _dominantMood(List<dynamic> entries) {
    if (entries.isEmpty) return null;
    final counts = <Mood, int>{};
    for (final e in entries) {
      counts[e.mood] = (counts[e.mood] ?? 0) + 1;
    }
    return counts.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
  }

  String _insightText(Mood mood) {
    switch (mood) {
      case Mood.happy:
        return "You've been mostly happy lately. Keep it up!";
      case Mood.neutral:
        return "Your week has been steady and balanced.";
      case Mood.sad:
        return "Tough week. Remember it gets better.";
      case Mood.excited:
        return "High energy week! Channel it well.";
      case Mood.anxious:
        return "Feeling anxious lately. Try some deep breaths.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MoodProvider>(
      builder: (context, provider, _) {
        final entries = provider.recentEntries;
        if (entries.isEmpty) return const SizedBox.shrink();

        final dominant = _dominantMood(entries);
        if (dominant == null) return const SizedBox.shrink();

        return AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(milliseconds: 400),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  dominant.lightColor,
                  dominant.color.withOpacity(0.12),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: dominant.color.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: dominant.color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${entries.length}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: dominant.color,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'This week\'s vibe: ${dominant.label}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _insightText(dominant),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
