import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppAnimations {
  static const Duration base = Duration(milliseconds: 450);
  static const Duration medium = Duration(milliseconds: 700);
  static const Duration slow = Duration(milliseconds: 1200);

  static List<Effect<dynamic>> cardEntrance(int index) {
    return <Effect<dynamic>>[
      FadeEffect(
        duration: base,
        curve: Curves.easeOut,
        delay: Duration(milliseconds: index * 70),
      ),
      SlideEffect(
        begin: const Offset(0, 0.08),
        end: Offset.zero,
        duration: medium,
        curve: Curves.easeOutCubic,
        delay: Duration(milliseconds: index * 70),
      ),
    ];
  }
}
