import 'package:flutter/material.dart';
import '../models/mood_entry.dart';
import '../painters/mood_face_painter.dart';

class MoodFaceWidget extends StatelessWidget {
  final Mood mood;
  final double size;
  final double animationValue;
  final bool isSelected;

  const MoodFaceWidget({
    super.key,
    required this.mood,
    this.size = 64,
    this.animationValue = 1.0,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: MoodFacePainter(
        mood: mood,
        faceColor: isSelected
            ? mood.color
            : mood.lightColor,
        strokeColor: isSelected
            ? darken(mood.color, 0.3)
            : mood.color.withOpacity(0.8),
        animationValue: animationValue,
      ),
    );
  }

  Color darken(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }
}
