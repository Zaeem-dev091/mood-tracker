import 'package:flutter/material.dart';
import '../models/mood_entry.dart';

class MoodFacePainter extends CustomPainter {
  final Mood mood;
  final Color faceColor;
  final Color strokeColor;
  final double animationValue; // 0.0 to 1.0 for bounce animation

  MoodFacePainter({
    required this.mood,
    required this.faceColor,
    required this.strokeColor,
    this.animationValue = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) * animationValue;

    final facePaint = Paint()
      ..color = faceColor
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.04
      ..strokeCap = StrokeCap.round;

    // Draw face circle
    canvas.drawCircle(center, radius, facePaint);
    canvas.drawCircle(
        center, radius, strokePaint..style = PaintingStyle.stroke);

    // Scale all features relative to radius
    final eyeOffsetX = radius * 0.32;
    final eyeOffsetY = radius * 0.28;
    final eyeRadius = radius * 0.1;
    final mouthY = center.dy + radius * 0.30;

    // Draw eyes (same for all moods, but size varies slightly)
    final eyePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.fill;

    switch (mood) {
      case Mood.excited:
        // Wide open eyes (larger)
        canvas.drawCircle(
          Offset(center.dx - eyeOffsetX, center.dy - eyeOffsetY),
          eyeRadius * 1.3,
          eyePaint,
        );
        canvas.drawCircle(
          Offset(center.dx + eyeOffsetX, center.dy - eyeOffsetY),
          eyeRadius * 1.3,
          eyePaint,
        );
        break;
      case Mood.anxious:
        // Slanted/worried eyebrows + normal eyes
        canvas.drawCircle(
          Offset(center.dx - eyeOffsetX, center.dy - eyeOffsetY),
          eyeRadius,
          eyePaint,
        );
        canvas.drawCircle(
          Offset(center.dx + eyeOffsetX, center.dy - eyeOffsetY),
          eyeRadius,
          eyePaint,
        );
        // Worried eyebrows (angled inward, upward)
        final browPaint = Paint()
          ..color = strokeColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = radius * 0.07
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(
          Offset(center.dx - eyeOffsetX - radius * 0.18,
              center.dy - eyeOffsetY - radius * 0.25),
          Offset(center.dx - eyeOffsetX + radius * 0.14,
              center.dy - eyeOffsetY - radius * 0.40),
          browPaint,
        );
        canvas.drawLine(
          Offset(center.dx + eyeOffsetX - radius * 0.14,
              center.dy - eyeOffsetY - radius * 0.40),
          Offset(center.dx + eyeOffsetX + radius * 0.18,
              center.dy - eyeOffsetY - radius * 0.25),
          browPaint,
        );
        break;
      default:
        canvas.drawCircle(
          Offset(center.dx - eyeOffsetX, center.dy - eyeOffsetY),
          eyeRadius,
          eyePaint,
        );
        canvas.drawCircle(
          Offset(center.dx + eyeOffsetX, center.dy - eyeOffsetY),
          eyeRadius,
          eyePaint,
        );
    }

    final mouthPaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.08
      ..strokeCap = StrokeCap.round;

    switch (mood) {
      case Mood.happy:
        // Big upward smile arc
        final smileRect = Rect.fromCenter(
          center: Offset(center.dx, mouthY - radius * 0.05),
          width: radius * 1.0,
          height: radius * 0.55,
        );
        canvas.drawArc(smileRect, 0.1, 2.9, false, mouthPaint);
        // Rosy cheeks
        final cheekPaint = Paint()
          ..color = const Color(0xFFFFB3B3).withOpacity(0.5)
          ..style = PaintingStyle.fill;
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(center.dx - eyeOffsetX * 1.4, mouthY - radius * 0.1),
            width: radius * 0.3,
            height: radius * 0.18,
          ),
          cheekPaint,
        );
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(center.dx + eyeOffsetX * 1.4, mouthY - radius * 0.1),
            width: radius * 0.3,
            height: radius * 0.18,
          ),
          cheekPaint,
        );

      case Mood.neutral:
        // Flat mouth line
        canvas.drawLine(
          Offset(center.dx - radius * 0.35, mouthY),
          Offset(center.dx + radius * 0.35, mouthY),
          mouthPaint,
        );
        // Flat straight eyebrows — distinct from happy arched brows and sad inward slant
        final neutralBrowPaint = Paint()
          ..color = strokeColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = radius * 0.07
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(
          Offset(center.dx - eyeOffsetX - radius * 0.18,
              center.dy - eyeOffsetY - radius * 0.28),
          Offset(center.dx - eyeOffsetX + radius * 0.18,
              center.dy - eyeOffsetY - radius * 0.28),
          neutralBrowPaint,
        );
        canvas.drawLine(
          Offset(center.dx + eyeOffsetX - radius * 0.18,
              center.dy - eyeOffsetY - radius * 0.28),
          Offset(center.dx + eyeOffsetX + radius * 0.18,
              center.dy - eyeOffsetY - radius * 0.28),
          neutralBrowPaint,
        );

      case Mood.sad:
        // Sad inward-raised eyebrows (inner corners raised = classic sad expression)
        final sadBrowPaint = Paint()
          ..color = strokeColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = radius * 0.07
          ..strokeCap = StrokeCap.round;
        // Left brow — inner end raised
        canvas.drawLine(
          Offset(center.dx - eyeOffsetX - radius * 0.18,
              center.dy - eyeOffsetY - radius * 0.22),
          Offset(center.dx - eyeOffsetX + radius * 0.14,
              center.dy - eyeOffsetY - radius * 0.38),
          sadBrowPaint,
        );
        // Right brow — inner end raised
        canvas.drawLine(
          Offset(center.dx + eyeOffsetX - radius * 0.14,
              center.dy - eyeOffsetY - radius * 0.38),
          Offset(center.dx + eyeOffsetX + radius * 0.18,
              center.dy - eyeOffsetY - radius * 0.22),
          sadBrowPaint,
        );
        // Downward frown arc
        final frownRect = Rect.fromCenter(
          center: Offset(center.dx, mouthY + radius * 0.30),
          width: radius * 0.9,
          height: radius * 0.50,
        );
        canvas.drawArc(frownRect, 3.4, 2.7, false, mouthPaint);
        // Tear drop
        final tearPaint = Paint()
          ..color = const Color(0xFF8BB8FF).withOpacity(0.8)
          ..style = PaintingStyle.fill;
        final tearPath = Path();
        final tearX = center.dx + eyeOffsetX;
        final tearY = center.dy - eyeOffsetY + radius * 0.18;
        tearPath.moveTo(tearX, tearY);
        tearPath.cubicTo(
          tearX - radius * 0.09,
          tearY + radius * 0.12,
          tearX - radius * 0.09,
          tearY + radius * 0.22,
          tearX,
          tearY + radius * 0.25,
        );
        tearPath.cubicTo(
          tearX + radius * 0.09,
          tearY + radius * 0.22,
          tearX + radius * 0.09,
          tearY + radius * 0.12,
          tearX,
          tearY,
        );
        canvas.drawPath(tearPath, tearPaint);

      case Mood.excited:
        // Big open-mouth grin
        final grinRect = Rect.fromCenter(
          center: Offset(center.dx, mouthY - radius * 0.05),
          width: radius * 1.1,
          height: radius * 0.65,
        );
        final grinPath = Path();
        grinPath.addArc(grinRect, 0.0, 3.14);
        grinPath.close();
        final grinFillPaint = Paint()
          ..color = strokeColor.withOpacity(0.15)
          ..style = PaintingStyle.fill;
        canvas.drawPath(grinPath, grinFillPaint);
        canvas.drawArc(grinRect, 0.0, 3.14, false, mouthPaint);
        // Exclamation marks as eyebrows
        final browPaint = Paint()
          ..color = strokeColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = radius * 0.07
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(
          Offset(
              center.dx - eyeOffsetX, center.dy - eyeOffsetY - radius * 0.22),
          Offset(
              center.dx - eyeOffsetX, center.dy - eyeOffsetY - radius * 0.42),
          browPaint,
        );
        canvas.drawLine(
          Offset(
              center.dx + eyeOffsetX, center.dy - eyeOffsetY - radius * 0.22),
          Offset(
              center.dx + eyeOffsetX, center.dy - eyeOffsetY - radius * 0.42),
          browPaint,
        );

      case Mood.anxious:
        // Wavy/nervous mouth
        final wavePath = Path();
        wavePath.moveTo(center.dx - radius * 0.38, mouthY);
        wavePath.cubicTo(
          center.dx - radius * 0.18,
          mouthY - radius * 0.15,
          center.dx - radius * 0.05,
          mouthY + radius * 0.15,
          center.dx,
          mouthY,
        );
        wavePath.cubicTo(
          center.dx + radius * 0.05,
          mouthY - radius * 0.15,
          center.dx + radius * 0.18,
          mouthY + radius * 0.15,
          center.dx + radius * 0.38,
          mouthY,
        );
        canvas.drawPath(wavePath, mouthPaint);
    }
  }

  @override
  bool shouldRepaint(MoodFacePainter oldDelegate) {
    return oldDelegate.mood != mood ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.faceColor != faceColor;
  }
}
