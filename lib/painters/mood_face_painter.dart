import 'package:flutter/material.dart';
import '../models/mood_entry.dart';

class MoodFacePainter extends CustomPainter {
  final Mood mood;
  final Color faceColor;
  final Color strokeColor;
  final double animationValue;

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

    final outlinePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.04
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, facePaint);
    canvas.drawCircle(center, radius, outlinePaint);

    final ex = radius * 0.32;
    final ey = radius * 0.28;
    final er = radius * 0.1;
    final my = center.dy + radius * 0.30;

    final eyePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.fill;

    final mouthPaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.08
      ..strokeCap = StrokeCap.round;

    final browPaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.07
      ..strokeCap = StrokeCap.round;

    switch (mood) {
      case Mood.excited:
        canvas.drawCircle(
            Offset(center.dx - ex, center.dy - ey), er * 1.3, eyePaint);
        canvas.drawCircle(
            Offset(center.dx + ex, center.dy - ey), er * 1.3, eyePaint);

        canvas.drawLine(
          Offset(center.dx - ex, center.dy - ey - radius * 0.22),
          Offset(center.dx - ex, center.dy - ey - radius * 0.42),
          browPaint,
        );
        canvas.drawLine(
          Offset(center.dx + ex, center.dy - ey - radius * 0.22),
          Offset(center.dx + ex, center.dy - ey - radius * 0.42),
          browPaint,
        );

        final grinRect = Rect.fromCenter(
          center: Offset(center.dx, my - radius * 0.05),
          width: radius * 1.1,
          height: radius * 0.65,
        );
        final grinPath = Path()
          ..addArc(grinRect, 0.0, 3.14)
          ..close();
        canvas.drawPath(
          grinPath,
          Paint()
            ..color = strokeColor.withOpacity(0.15)
            ..style = PaintingStyle.fill,
        );
        canvas.drawArc(grinRect, 0.0, 3.14, false, mouthPaint);

      case Mood.anxious:
        canvas.drawCircle(Offset(center.dx - ex, center.dy - ey), er, eyePaint);
        canvas.drawCircle(Offset(center.dx + ex, center.dy - ey), er, eyePaint);

        canvas.drawLine(
          Offset(
              center.dx - ex - radius * 0.18, center.dy - ey - radius * 0.25),
          Offset(
              center.dx - ex + radius * 0.14, center.dy - ey - radius * 0.40),
          browPaint,
        );
        canvas.drawLine(
          Offset(
              center.dx + ex - radius * 0.14, center.dy - ey - radius * 0.40),
          Offset(
              center.dx + ex + radius * 0.18, center.dy - ey - radius * 0.25),
          browPaint,
        );

        final wavePath = Path();
        wavePath.moveTo(center.dx - radius * 0.38, my);
        wavePath.cubicTo(
          center.dx - radius * 0.18,
          my - radius * 0.15,
          center.dx - radius * 0.05,
          my + radius * 0.15,
          center.dx,
          my,
        );
        wavePath.cubicTo(
          center.dx + radius * 0.05,
          my - radius * 0.15,
          center.dx + radius * 0.18,
          my + radius * 0.15,
          center.dx + radius * 0.38,
          my,
        );
        canvas.drawPath(wavePath, mouthPaint);

      case Mood.happy:
        canvas.drawCircle(Offset(center.dx - ex, center.dy - ey), er, eyePaint);
        canvas.drawCircle(Offset(center.dx + ex, center.dy - ey), er, eyePaint);

        final smileRect = Rect.fromCenter(
          center: Offset(center.dx, my - radius * 0.05),
          width: radius * 1.0,
          height: radius * 0.55,
        );
        canvas.drawArc(smileRect, 0.1, 2.9, false, mouthPaint);

        final cheekPaint = Paint()
          ..color = const Color(0xFFFFB3B3).withOpacity(0.5)
          ..style = PaintingStyle.fill;
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(center.dx - ex * 1.4, my - radius * 0.1),
            width: radius * 0.3,
            height: radius * 0.18,
          ),
          cheekPaint,
        );
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(center.dx + ex * 1.4, my - radius * 0.1),
            width: radius * 0.3,
            height: radius * 0.18,
          ),
          cheekPaint,
        );

      case Mood.neutral:
        canvas.drawCircle(Offset(center.dx - ex, center.dy - ey), er, eyePaint);
        canvas.drawCircle(Offset(center.dx + ex, center.dy - ey), er, eyePaint);

        canvas.drawLine(Offset(center.dx - radius * 0.35, my),
            Offset(center.dx + radius * 0.35, my), mouthPaint);

        canvas.drawLine(
          Offset(
              center.dx - ex - radius * 0.18, center.dy - ey - radius * 0.28),
          Offset(
              center.dx - ex + radius * 0.18, center.dy - ey - radius * 0.28),
          browPaint,
        );
        canvas.drawLine(
          Offset(
              center.dx + ex - radius * 0.18, center.dy - ey - radius * 0.28),
          Offset(
              center.dx + ex + radius * 0.18, center.dy - ey - radius * 0.28),
          browPaint,
        );

      case Mood.sad:
        canvas.drawCircle(Offset(center.dx - ex, center.dy - ey), er, eyePaint);
        canvas.drawCircle(Offset(center.dx + ex, center.dy - ey), er, eyePaint);

        canvas.drawLine(
          Offset(
              center.dx - ex - radius * 0.18, center.dy - ey - radius * 0.22),
          Offset(
              center.dx - ex + radius * 0.14, center.dy - ey - radius * 0.38),
          browPaint,
        );
        canvas.drawLine(
          Offset(
              center.dx + ex - radius * 0.14, center.dy - ey - radius * 0.38),
          Offset(
              center.dx + ex + radius * 0.18, center.dy - ey - radius * 0.22),
          browPaint,
        );

        final frownRect = Rect.fromCenter(
          center: Offset(center.dx, my + radius * 0.30),
          width: radius * 0.9,
          height: radius * 0.50,
        );
        canvas.drawArc(frownRect, 3.4, 2.7, false, mouthPaint);

        final tearPath = Path();
        final tx = center.dx + ex;
        final ty = center.dy - ey + radius * 0.18;
        tearPath.moveTo(tx, ty);
        tearPath.cubicTo(tx - radius * 0.09, ty + radius * 0.12,
            tx - radius * 0.09, ty + radius * 0.22, tx, ty + radius * 0.25);
        tearPath.cubicTo(tx + radius * 0.09, ty + radius * 0.22,
            tx + radius * 0.09, ty + radius * 0.12, tx, ty);
        canvas.drawPath(
          tearPath,
          Paint()
            ..color = const Color(0xFF8BB8FF).withOpacity(0.8)
            ..style = PaintingStyle.fill,
        );
    }
  }

  @override
  bool shouldRepaint(MoodFacePainter oldDelegate) {
    return oldDelegate.mood != mood ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.faceColor != faceColor;
  }
}
