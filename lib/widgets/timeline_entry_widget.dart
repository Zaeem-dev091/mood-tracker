import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/mood_entry.dart';
import 'mood_face_widget.dart';

class TimelineEntryWidget extends StatefulWidget {
  final MoodEntry entry;
  final bool isFirst;

  const TimelineEntryWidget({
    super.key,
    required this.entry,
    this.isFirst = false,
  });

  @override
  State<TimelineEntryWidget> createState() => _TimelineEntryWidgetState();
}

class _TimelineEntryWidgetState extends State<TimelineEntryWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _faceAnim;
  late Animation<double> _glowAnim;
  bool _isBouncing = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnim = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.18)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.18, end: 0.94)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.94, end: 1.04)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.04, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 20,
      ),
    ]).animate(_controller);

    _faceAnim = TweenSequence<double>([
      TweenSequenceItem(
        tween:
            Tween(begin: 1.0, end: 0.7).chain(CurveTween(curve: Curves.easeIn)),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.7, end: 1.0)
            .chain(CurveTween(curve: Curves.elasticOut)),
        weight: 75,
      ),
    ]).animate(_controller);

    _glowAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _isBouncing = false);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _triggerBounce() {
    if (_isBouncing) return;
    setState(() => _isBouncing = true);
    _controller.forward(from: 0);
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM d').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final mood = widget.entry.mood;

    return GestureDetector(
      onTap: _triggerBounce,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _isBouncing ? _scaleAnim.value : 1.0,
            child: Container(
              width: 110,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _isBouncing
                      ? mood.color.withOpacity(_glowAnim.value * 0.8)
                      : mood.color.withOpacity(0.25),
                  width: _isBouncing ? 2.0 : 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: mood.color.withOpacity(
                        _isBouncing ? _glowAnim.value * 0.3 : 0.08),
                    blurRadius: _isBouncing ? 16 : 8,
                    spreadRadius: _isBouncing ? 2 : 0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 14),
                  Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: mood.color,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 12),
                  MoodFaceWidget(
                    mood: mood,
                    size: 60,
                    isSelected: true,
                    animationValue: _isBouncing ? _faceAnim.value : 1.0,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _formatDate(widget.entry.date),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 14),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
