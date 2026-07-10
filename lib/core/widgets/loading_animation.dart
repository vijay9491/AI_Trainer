import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({
    super.key,
    required this.text,
  });

  final String text;

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 180,
          height: 180,
          child: Stack(
            alignment: Alignment.center,
            children: [
              RotationTransition(
                turns: CurvedAnimation(parent: _controller, curve: Curves.linear),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2.2,
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.24),
                    ),
                  ),
                ),
              ),
              Lottie.asset(
                'assets/lottie/health_pulse.json',
                width: 120,
                height: 120,
                repeat: true,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.auto_awesome_rounded,
                  size: 72,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(widget.text, style: Theme.of(context).textTheme.titleMedium)
            .animate(onPlay: (c) => c.repeat())
            .fadeIn(duration: 500.ms)
            .fadeOut(duration: 500.ms),
      ],
    );
  }
}
