import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/mood_entry.dart';
import '../providers/mood_provider.dart';
import 'mood_face_widget.dart';

class MoodSelectorWidget extends StatelessWidget {
  const MoodSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoodProvider>(
      builder: (context, provider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How are you feeling?',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap a face to log your mood',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade500,
                  ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: Mood.values.map((mood) {
                return _MoodTapTarget(
                  mood: mood,
                  onTap: () {
                    provider.logMoodDirectly(mood);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${mood.label} logged!'),
                        duration: const Duration(milliseconds: 900),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: mood.color,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}

class _MoodTapTarget extends StatefulWidget {
  final Mood mood;
  final VoidCallback onTap;

  const _MoodTapTarget({
    required this.mood,
    required this.onTap,
  });

  @override
  State<_MoodTapTarget> createState() => _MoodTapTargetState();
}

class _MoodTapTargetState extends State<_MoodTapTarget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  bool _tapped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _scale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.22)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 35,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.22, end: 0.92)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.92, end: 1.0)
            .chain(CurveTween(curve: Curves.elasticOut)),
        weight: 35,
      ),
    ]).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (mounted) setState(() => _tapped = false);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() => _tapped = true);
    _controller.forward(from: 0);
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Transform.scale(
            scale: _tapped ? _scale.value : 1.0,
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _tapped
                        ? widget.mood.lightColor
                        : Colors.grey.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _tapped
                          ? widget.mood.color
                          : Colors.grey.withOpacity(0.15),
                      width: 1.5,
                    ),
                  ),
                  child: MoodFaceWidget(
                    mood: widget.mood,
                    size: 56,
                    isSelected: _tapped,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.mood.label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _tapped ? widget.mood.color : Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
