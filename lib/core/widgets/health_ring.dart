import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/app_spacing.dart';
import 'circular_progress.dart';

class HealthRing extends StatelessWidget {
  const HealthRing({
    super.key,
    required this.score,
  });

  final int score;

  @override
  Widget build(BuildContext context) {
    final progress = score / 100;
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: progress),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        final shownScore = (value * 100).round();
        return SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: const Size.square(200),
                painter: CircularProgressPainter(progress: value, strokeWidth: 14),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('$shownScore%', style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(height: AppSpacing.xs),
                  Text('Daily Health Score', style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ],
          ),
        );
      },
    ).animate().scale(duration: 700.ms, curve: Curves.easeOutBack);
  }
}
